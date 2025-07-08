return {
		"ThePrimeagen/harpoon",
		config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

			vim.keymap.set("n", "<leader>a", function()
                print("Adding file to Harpoon")
                mark.add_file()
            end, { desc = "Harpoon: Add file" })

			vim.keymap.set("n", "<C-e>", function()
                print("Toggling Harpoon UI")
			    ui.toggle_quick_menu()
			end)

            vim.keymap.set("n", "<C-h>", function()
                print("Navigating to Harpoon file 1")
                ui.nav_file(1)
            end, { desc = "Harpoon: Navigate to file 1" })

            vim.keymap.set("n", "<C-t>", function()
                print("Navigating to Harpoon file 2")
                ui.nav_file(2)
            end, { desc = "Harpoon: Navigate to file 2" })

            vim.keymap.set("n", "<C-n>", function()
                print("Navigating to Harpoon file 3")
                ui.nav_file(3)
            end, { desc = "Harpoon: Navigate to file 3" })

            vim.keymap.set("n", "<C-s>", function()
                print("Navigating to Harpoon file 4")
                ui.nav_file(4)
            end, { desc = "Harpoon: Navigate to file 4" })
		end,
	}





