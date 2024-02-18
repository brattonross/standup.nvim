local M = {}

M.root_dir = vim.fs.normalize("~/.local/share/nvim/standup")

M.current = function()
	M._edit_note(os.time())
end

M.next = function()
	M._edit_note(M._working_day_after(os.time()))
end

M.previous = function()
	M._edit_note(M._working_day_before(os.time()))
end

---@param time integer
M._edit_note = function(time)
	local date = os.date("%Y-%m-%d", time)
	local filename = date .. ".md"
	local filepath = vim.fs.joinpath(M.root_dir, filename)

	if vim.fn.filereadable(filepath) == 0 or vim.fn.getfsize(filepath) == 0 then
		vim.fn.writefile({ "# " .. date, "" }, filepath)
	end

	vim.cmd.edit(filepath)
end

-- The following functions are based on functions from:
-- https://github.com/epwalsh/obsidian.nvim/blob/main/lua/obsidian/util.lua

---@param time integer
---@return boolean
M._is_working_day = function(time)
	local is_saturday = (os.date("%w", time) == "6")
	local is_sunday = (os.date("%w", time) == "0")
	return not (is_saturday or is_sunday)
end

---@param time integer
---@return integer
M._working_day_before = function(time)
	local previous_day = time - (24 * 60 * 60)
	if M._is_working_day(previous_day) then
		return previous_day
	else
		return M._working_day_before(previous_day)
	end
end

---@param time integer
---@return integer
M._working_day_after = function(time)
	local next_day = time + (24 * 60 * 60)
	if M._is_working_day(next_day) then
		return next_day
	else
		return M._working_day_after(next_day)
	end
end

---@class StandupOptions
---@field root_dir? string

---@param opts StandupOptions
M.setup = function(opts)
	if opts.root_dir then
		M.root_dir = opts.root_dir
	end

	if vim.fn.isdirectory(M.root_dir) == 0 then
		local result = vim.fn.mkdir(M.root_dir, "p")
		if result == 0 then
			vim.api.nvim_err_writeln("Failed to create directory: " .. M.root_dir)
		end
	end
end

return M
