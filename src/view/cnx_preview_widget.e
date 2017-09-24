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
			create colors
			wipe_out
		end

feature -- Access

	widget: EV_PIXMAP

	actions: ACTION_SEQUENCE

	background_color: EV_COLOR
		attribute
			Result := colors.dark_slate_blue
		end

	foreground_color: EV_COLOR
		attribute
			create Result.make_with_rgb (1.0, 1.0, 1.0)
		end

feature -- Setters

	set_background_color (a_color: EV_COLOR)
		do
			background_color := a_color
		end

	set_foreground_color (a_color: EV_COLOR)
		do
			foreground_color := a_color
		end

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
			a_widget.set_background_color (background_color)
			a_widget.set_foreground_color (foreground_color)
		end

	on_draw_text (a_text: STRING; a_widget: like widget)
		local
			l_line_width,
			l_line_height: INTEGER
			l_orig_x,
			l_orgi_y: INTEGER
			l_font: EV_FONT
			l_font_height,
			l_this_top,
			l_font_width: INTEGER
			l_longest_string: STRING
			l_list: LIST [STRING]
		do
			create l_font.make_with_values ({EV_FONT_CONSTANTS}.family_screen, {EV_FONT_CONSTANTS}.weight_regular, {EV_FONT_CONSTANTS}.shape_regular, 1)
			l_list := a_text.split ('|')

				-- Compute the longest string
			across
				l_list as ic
			from
				create l_longest_string.make_empty
			loop
				if ic.item.count > l_longest_string.count then
					l_longest_string := ic.item
				end
			end
				-- Compute font height based on it
			from
				l_font_height := 1
				l_font_width := 0
			until
				(((margin * 2) + l_font_width) / a_widget.width) > 0.95 or
				((margin * 2) + (l_list.count * (l_font_height + 3))) / a_widget.height > 0.95
			loop
				l_font.set_height (l_font_height)
				l_font_width := l_font.string_width (l_longest_string)
				l_font_height := l_font_height + 1
			end
				-- Draw each line of text using calcs above
			across
				l_list as ic
			loop
				a_widget.set_font (l_font)
				a_widget.draw_text_top_left (((a_widget.width - l_font_width) / 2).truncated_to_integer, l_this_top, ic.item)
				l_this_top := l_this_top + 3 + l_font.height
			end
		end

feature -- Constants

	colors: CNX_STOCK_COLORS

	margin: INTEGER = 20

end
