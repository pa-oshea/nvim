local ls = require("luasnip")
local partial = require("luasnip.extras").partial
local fn = vim.fn

local function uuid()
	math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 9)))
	local random = math.random
	local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
	return string.gsub(template, "[xy]", function(c)
		local v = (c == "x") and random(0, 0xf) or random(8, 0xb)
		return string.format("%x", v)
	end)
end
local function run_command(cmd, ...)
	local result = fn.systemlist(cmd, ...)
	return result
end

ls.add_snippets("all", {
	ls.s("pwd", { partial(run_command, "pwd") }),
	ls.s("hlc", ls.t("http://localhost")),
	ls.s("hl1", ls.t("http://127.0.0.1")),
	ls.s("lh", ls.t("localhost")),
	ls.s("lh1", ls.t("127.0.0.1")),
	ls.s({ trig = "uid", wordTrig = true }, { ls.f(uuid), ls.i(0) }),
})
