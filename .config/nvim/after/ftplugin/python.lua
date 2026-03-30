local root = vim.fs.root(0, { ".venv" })
if root then
  local venv = vim.fs.joinpath(root, ".venv")
  vim.env.VIRTUAL_ENV = venv
  vim.env.PATH = vim.fs.joinpath(venv, "bin") .. ":" .. vim.env.PATH
end
