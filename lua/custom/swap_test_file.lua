local M = {}

function M.swap_source_test()
  local filepath = vim.fn.expand "%:p"
  local is_test_file = filepath:match "%.test%.ts$"
  local target_filepath

  if is_test_file then
    -- Swap to source file
    target_filepath = filepath:gsub("%.test%.ts$", ".ts")
  else
    -- Swap to test file
    target_filepath = filepath:gsub("%.ts$", ".test.ts")
  end

  -- Check if the target file exists
  if vim.fn.filereadable(target_filepath) == 1 then
    vim.cmd("edit " .. target_filepath)
  else
    print("File not found: " .. target_filepath)
  end
end

return M
