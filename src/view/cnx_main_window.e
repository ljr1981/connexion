note
	description: "[
		Representation of the Main Window for Connexion.
		]"

class
	CNX_MAIN_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			create_interface_objects,
			initialize
		end

create
	make_with_title

feature {NONE} -- GUI

	display_window: CNX_DISPLAY_WINDOW

feature {NONE} -- GUI bits

	main_box: EV_VERTICAL_BOX
		

feature {NONE} -- Initialization

	create_interface_objects
			-- <Precursor>
		do
			create display_window

			create main_box

			Precursor
		end

	initialize
			-- <Precursor>
		do
			display_window.set_size (800, 600)
			close_request_actions.extend (agent display_window.destroy)

			display_window.show

				-- Stuff inside main_box

				-- Extensions
				-- Disables
				-- Settings
				-- Borders & Padding
				-- Other Misc


				-- Extension to main
			extend (main_box)

			Precursor
		end

end
