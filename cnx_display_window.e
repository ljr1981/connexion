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

feature {NONE} -- GUI

feature {NONE} -- Initialization

	create_interface_objects
			-- <Precursor>
		do
			Precursor
		end

	initialize
			-- <Precursor>
		do
			set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			pointer_double_press_actions.extend (agent on_double_click)
			Precursor
		end

feature {NONE} -- Implementation

	on_double_click (a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32)
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
		end

end
