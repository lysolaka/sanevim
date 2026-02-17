-- texlab Configuration --

-- Most of the code is kindly borrowed from `neovim/nvim-lspconfig`

-- Table of [`<bufnr>`] = `<is_build_enabled>`
local texlab_build_enabled = {}

local function buf_build(client, bufnr)
  local win = vim.api.nvim_get_current_win()
  local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
  client:request("textDocument/build", params, function(err, result)
    local build_status = {
      [0] = "Success",
      [1] = "Error",
      [2] = "Failure",
      [3] = "Cancelled",
    }
    if err then
      vim.notify(err.code .. ": " .. err.message, vim.log.levels.ERROR)
    end
    vim.notify("Build: " .. build_status[result.status], vim.log.levels.INFO)
  end, bufnr)
end

local function buf_build_toggle(client, bufnr)
  if texlab_build_enabled[bufnr] then
    local augroup = "TexlabBuildOnSave_" .. bufnr
    vim.api.nvim_del_augroup_by_name(augroup)

    texlab_build_enabled[bufnr] = nil
    vim.notify("Continuous build disabled", vim.log.levels.INFO)
  else
    local augroup = "TexlabBuildOnSave_" .. bufnr
    vim.api.nvim_create_augroup(augroup, { clear = true })

    vim.api.nvim_create_autocmd("BufWritePost", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        buf_build(client, bufnr)
      end,
    })

    texlab_build_enabled[bufnr] = true
    vim.notify("Continuous build enabled", vim.log.levels.INFO)
  end
end

local function buf_build_stop(_, bufnr)
  if texlab_build_enabled[bufnr] then
    local augroup = "TexlabBuildOnSave_" .. bufnr
    vim.api.nvim_del_augroup_by_name(augroup)

    texlab_build_enabled[bufnr] = nil
    vim.notify("Continuous build disabled", vim.log.levels.INFO)
  else
    vim.notify("Continuous build is not enabled for this buffer", vim.log.levels.WARN)
  end
end

local function buf_search(client, bufnr)
  local win = vim.api.nvim_get_current_win()
  local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
  client:request("textDocument/forwardSearch", params, function(err, result)
    local search_status = {
      [0] = "Success",
      [1] = "Error",
      [2] = "Failure",
      [3] = "Unconfigured",
    }
    if err then
      vim.notify(err.code .. ": " .. err.message, vim.log.levels.ERROR)
    end
    vim.notify("Forward search: " .. search_status[result.status], vim.log.levels.INFO)
  end, bufnr)
end

local function buf_cancel_build(client, bufnr)
  return client:exec_cmd({
    title = "cancel",
    command = "texlab.cancelBuild",
  }, { bufnr = bufnr })
end

local function buf_depgraph(client, bufnr)
  client:exec_cmd({ command = "texlab.showDependencyGraph" }, { bufnr = bufnr }, function(err, result)
    if err then
      return vim.notify(err.code .. ": " .. err.message, vim.log.levels.ERROR)
    end
    vim.notify("The dependency graph has been generated:\n" .. result, vim.log.levels.INFO)
  end)
end

local function buf_clean_auxiliary(client, bufnr)
  client:exec_cmd(
    {
      title = "clean_auxiliary",
      command = "texlab.cleanAuxiliary",
      arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
    },
    { bufnr = bufnr }, function(err, _)
      if err then
        vim.notify("Failed to clean auxiliary files: " .. err.message, vim.log.levels.ERROR)
      else
        vim.notify("Auxiliary files cleaned", vim.log.levels.INFO)
      end
    end)
end

local function buf_clean_artifacts(client, bufnr)
  client:exec_cmd(
    {
      title = "clean_artifacts",
      command = "texlab.cleanArtifacts",
      arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
    },
    { bufnr = bufnr },
    function(err, _)
      if err then
        vim.notify("Failed to clean artifacts files: " .. err.message, vim.log.levels.ERROR)
      else
        vim.notify("Artifacts cleaned", vim.log.levels.INFO)
      end
    end)
end

local function buf_find_envs(client, bufnr)
  local win = vim.api.nvim_get_current_win()
  client:exec_cmd({
    command = "texlab.findEnvironments",
    arguments = { vim.lsp.util.make_position_params(win, client.offset_encoding) },
  }, { bufnr = bufnr }, function(err, result)
    if err then
      return vim.notify(err.code .. ": " .. err.message, vim.log.levels.ERROR)
    end
    local env_names = {}
    local max_length = 1
    for _, env in ipairs(result) do
      table.insert(env_names, env.name.text)
      max_length = math.max(max_length, string.len(env.name.text))
    end
    for i, name in ipairs(env_names) do
      env_names[i] = string.rep(" ", i - 1) .. name
    end
    vim.lsp.util.open_floating_preview(env_names, "", {
      height = #env_names,
      width = math.max((max_length + #env_names - 1), (string.len "Environments")),
      focusable = false,
      focus = false,
      title = "Environments",
    })
  end)
end

local function buf_change_env(client, bufnr)
  vim.ui.input({ prompt = "New environment name: " }, function(input)
    if not input or input == "" then
      return vim.notify("No environment name provided", vim.log.levels.WARN)
    end
    local pos = vim.api.nvim_win_get_cursor(0)
    return client:exec_cmd({
      title = "change_environment",
      command = "texlab.changeEnvironment",
      arguments = {
        {
          textDocument = { uri = vim.uri_from_bufnr(bufnr) },
          position = { line = pos[1] - 1, character = pos[2] },
          newName = tostring(input),
        },
      },
    }, { bufnr = bufnr })
  end)
end

return {
  settings = {
    texlab = {
      build = {
        executable = "latexmk",
        args = { "-verbose", "-pdflua", "-file-line-error", "-synctex=1", "-interaction=nonstopmode", "-auxdir=%f.auxdir", "%f" },
        onSave = false,
        forwardSearchAfter = true,
      },
      forwardSearch = {
        executable = "qpdfview",
        args = { "--unique", "%p#src:%f:%l:1" },
      },
      chktex = {
        onOpenAndSave = true,
      },
      latexFormatter = "tex-fmt",
      formatterLineLength = 100,
    },
  },
  on_attach = function(client, bufnr)
    for _, cmd in ipairs({
      { name = "TexlabBuild",             fn = buf_build_toggle,    desc = "Toggle continuous build of the current buffer" },
      { name = "TexlabBuildStop",         fn = buf_build_stop,      desc = "Stop the continuous build" },
      { name = "TexlabBuildSS",           fn = buf_build,           desc = "Build the current buffer" },
      { name = "TexlabBuildCancel",       fn = buf_cancel_build,    desc = "Cancel the current build" },
      { name = "TexlabForward",           fn = buf_search,          desc = "Forward search from current position" },
      { name = "TexlabCleanAuxiliary",    fn = buf_clean_auxiliary, desc = "Clean auxiliary files" },
      { name = "TexlabCleanArtifacts",    fn = buf_clean_artifacts, desc = "Clean build artifacts" },
      { name = "TexlabDependencyGraph",   fn = buf_depgraph,        desc = "Show the dependency graph" },
      { name = "TexlabFindEnvironments",  fn = buf_find_envs,       desc = "Find the environments at current position" },
      { name = "TexlabChangeEnvironment", fn = buf_change_env,      desc = "Change the environment at current position" },
    }) do
      vim.api.nvim_buf_create_user_command(bufnr, cmd.name, function()
        cmd.fn(client, bufnr)
      end, { desc = cmd.desc })
    end
  end,
}
