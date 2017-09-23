note
	description: "[
		A Pixmap Preview Widget
		]"

class
	CNX_PREVIEW_WIDGET

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- <Precursor>
		do
			Precursor
			create widget
			create actions
			wipe_out
		end

feature -- Access

	widget: EV_PIXMAP

	actions: ACTION_SEQUENCE

feature -- Setters

	set_widget (a_widget: like widget)
		do
			widget := a_widget
		end

	wipe_out
		do
			actions.wipe_out
			actions.force (agent blank_out)
			actions.call ([widget])
		end

	start_new_actions (a_agent: PROCEDURE [EV_PIXMAP])
		do
			actions.wipe_out
			actions.force (a_agent)
		end

	set_actions_twin (a_actions: like actions)
		do
			actions.wipe_out
			across
				a_actions.twin as ic
			loop
				actions.force (ic.item)
			end
		end

feature -- Events

feature -- Ops

	refresh
		do
			widget.clear
			actions.call (widget)
			widget.refresh_now
			widget.show
		end

	blank_out (a_widget: like widget)
		local
			l_font: EV_FONT
		do
			a_widget.clear
			a_widget.set_background_color (create {EV_COLOR}.make_with_rgb (0.0, 0.0, 0.0))
			a_widget.set_foreground_color (create {EV_COLOR}.make_with_rgb (1.0, 1.0, 1.0))
			create l_font.make_with_values ({EV_FONT_CONSTANTS}.family_screen, {EV_FONT_CONSTANTS}.weight_regular, {EV_FONT_CONSTANTS}.shape_regular, 20)
			a_widget.set_font (l_font)
			a_widget.draw_text (100, 100, ":-)")
		end

end
