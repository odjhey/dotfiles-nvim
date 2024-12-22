local M = {}

function M.swap_source_index()
  local filepath = vim.fn.expand "%:p" -- Full path of current file
  local directory = vim.fn.fnamemodify(filepath, ":h") -- Extract directory
  local target_filepath

  -- Always target index.ts in the current directory
  target_filepath = directory .. "/index.ts"

  -- Check if the target file exists
  if vim.fn.filereadable(target_filepath) == 1 then
    vim.cmd("edit " .. vim.fn.fnameescape(target_filepath)) -- Open target file safely
  else
    print("File not found: " .. target_filepath)
  end
end

return M
