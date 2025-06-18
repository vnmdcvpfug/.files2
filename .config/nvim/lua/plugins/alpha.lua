return {
  'goolord/alpha-nvim',
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

    dashboard.config.layout[1].val = 4
    dashboard.config.layout[3].val = 4
		
    dashboard.section.header.val = { ("n  e  o  v  i  m") }
		
    dashboard.section.buttons.val = {
			dashboard.button("e", "New", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "Find", ":Telescope find_files<CR>"),
			dashboard.button("q", "Exit", ":qa<CR>"),
		}
    
		alpha.setup(dashboard.opts)
	end,
}
