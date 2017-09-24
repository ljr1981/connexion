note
	description: "[
		Representation of the Display Window for Connexion.
		]"

class
	CNX_DISPLAY_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			create_interface_objects,
			initialize
		end

create
	default_create,
	make_with_title

feature {CNX_MAIN_WINDOW, CNX_PREVIEW_ITEM} -- GUI Bits

	display: CNX_PREVIEW_WIDGET

feature {NONE} -- Initialization

	create_interface_objects
			-- <Precursor>
		do
			create display
			Precursor
		end

	initialize
			-- <Precursor>
		do
				-- Extensions
			extend (display.widget)

				-- Settings
			set_background_color (constants.colors.blue)

			Precursor

				-- Events
			display.widget.set_size (constants.default_window_width, constants.default_window_height)
			display.widget.pointer_double_press_actions.extend (agent on_resize)
			display.wipe_out
		end

feature {NONE} -- Implementation

	on_resize (a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32)
		do
			if is_border_enabled then
				disable_border
				disable_user_resize
				maximize
			else
				enable_border
				enable_user_resize
				restore
			end
			refresh_now
			display.widget.set_size (width, height)
			display.refresh
		end

feature {NONE} -- Constants

	constants: CNX_CONSTANTS once create Result end

end
