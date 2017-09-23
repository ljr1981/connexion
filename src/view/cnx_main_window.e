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

	main_box: CNX_PLAIN_HORIZONTAL_BOX_WIDGET -- ::=

		list_box: CNX_PLAIN_VERTICAL_BOX_WIDGET -- ::=

			announcement_list,
			song_list,
			notes_list: CNX_ITEM_LIST

		preview_box: CNX_PLAIN_VERTICAL_BOX_WIDGET -- ::=

		display_box: CNX_PLAIN_VERTICAL_BOX_WIDGET -- ::=

feature {NONE} -- Initialization

	create_interface_objects
			-- <Precursor>
		do
			create display_window

			create main_box
				create list_box
					create announcement_list.make ("Announcements")
					create song_list.make ("Songs")
					create notes_list.make ("Notes")
				create preview_box
				create display_box

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
			main_box.widget.extend (list_box.widget)
				list_box.widget.extend (announcement_list.widget)
				list_box.widget.extend (song_list.widget)
				list_box.widget.extend (notes_list.widget)
			main_box.widget.extend (preview_box.widget)
				preview_box.widget.extend (create {EV_CELL})
			main_box.widget.extend (display_box.widget)
				display_box.widget.extend (create {EV_CELL})

				-- Disables
				-- Settings
				-- Borders & Padding
				-- Other Misc

				-- Extension to main
			extend (main_box.widget)

			Precursor
		end

end
