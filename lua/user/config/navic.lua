require("nvim-navic").setup({
	icons = {
		File = " ",
		Module = " ",
		Namespace = " ",
		Package = " ",
		Class = " ",
		Method = " ",
		Property = " ",
		Field = " ",
		Constructor = " ",
		Enum = "練",
		Interface = "練",
		Function = " ",
		Variable = " ",
		Constant = " ",
		String = " ",
		Number = " ",
		Boolean = "◩ ",
		Array = " ",
		Object = " ",
		Key = " ",
		Null = "ﳠ ",
		EnumMember = " ",
		Struct = " ",
		Event = " ",
		Operator = " ",
		TypeParameter = " ",
	},
	highlight = true,
	separator = "   ",
	depth_limit = 0,
	depth_limit_indicator = "…",
	safe_output = true,
})

-- shim for missing highlights
local function set_hl(name, existing)
	vim.api.nvim_set_hl(0, name, { link = existing })
end

set_hl("NavicIconsFile", "WinBar")
set_hl("NavicIconsModule", "TSType")
set_hl("NavicIconsNamespace", "TSType")
set_hl("NavicIconsPackage", "TSInclude")
set_hl("NavicIconsClass", "TSType")
set_hl("NavicIconsMethod", "TSFunction")
set_hl("NavicIconsProperty", "TSProperty")
set_hl("NavicIconsField", "TSField")
set_hl("NavicIconsConstructor", "TSConstructor")
set_hl("NavicIconsEnum", "TSType")
set_hl("NavicIconsInterface", "TSType")
set_hl("NavicIconsFunction", "TSFunction")
set_hl("NavicIconsVariable", "TSVariable")
set_hl("NavicIconsConstant", "TSConstant")
set_hl("NavicIconsString", "TSString")
set_hl("NavicIconsNumber", "TSNumber")
set_hl("NavicIconsBoolean", "TSBoolean")
set_hl("NavicIconsArray", "TSVariable")
set_hl("NavicIconsObject", "TSVariable")
set_hl("NavicIconsKey", "TSConstant")
set_hl("NavicIconsNull", "TSConstBuiltin")
set_hl("NavicIconsEnumMember", "TSProperty")
set_hl("NavicIconsStruct", "TSType")
set_hl("NavicIconsEvent", "TSFuncBuiltin")
set_hl("NavicIconsOperator", "TSOperator")
set_hl("NavicIconsTypeParameter", "TSType")
set_hl("NavicText", "WinBar")
set_hl("NavicSeparator", "WinSeparator")

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
