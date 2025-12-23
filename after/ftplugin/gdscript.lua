-- GDScript settings + LSP only
local port = os.getenv "GDScript_Port" or "6005"

vim.lsp.start {
  name = "Godot",
  cmd = vim.lsp.rpc.connect("127.0.0.1", tonumber(port)),
  root_dir = vim.fs.dirname(vim.fs.find({ "project.godot", ".git" }, { upward = true })[1]),
}
