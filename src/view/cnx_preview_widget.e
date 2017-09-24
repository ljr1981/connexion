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
			Result := colors.white_smoke
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

	on_draw_citation (a_text: STRING; a_widget: like widget)
		local
			l_font: EV_FONT
			l_font_height: INTEGER
			l_this_top: INTEGER
			l_font_width: INTEGER
			l_longest_string: STRING
			l_list: LIST [STRING]
			l_indent: INTEGER
		do
			create l_font.make_with_values ({EV_FONT_CONSTANTS}.family_screen, {EV_FONT_CONSTANTS}.weight_regular, {EV_FONT_CONSTANTS}.shape_regular, 20)
			l_font_width := l_font.string_width (a_text)
			l_this_top := a_widget.height - (l_font_height + bottom_margin_height)
			a_widget.set_font (l_font)
			a_widget.draw_text_top_left (margin, l_this_top, a_text)
		end

	on_draw_text (a_text: STRING; a_widget: like widget)
		local
			l_font: EV_FONT
			l_font_height: INTEGER
			l_this_top: INTEGER
			l_font_width: INTEGER
			l_longest_string: STRING
			l_list: LIST [STRING]
			l_indent: INTEGER
			l_line: STRING
		do
			create l_font.make_with_values ({EV_FONT_CONSTANTS}.family_screen, {EV_FONT_CONSTANTS}.weight_regular, {EV_FONT_CONSTANTS}.shape_regular, 1)
			l_list := a_text.split (pipe_char)

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
				l_font_height := one
				l_font_width := nothing
			until
				(((margin * double) + l_font_width) / a_widget.width) > eighty_percent or
				((margin * double) + (l_list.count * (l_font_height + padding_and_border_pixels))) / a_widget.height > eighty_percent
			loop
				l_font.set_height (l_font_height)
				l_font_width := l_font.string_width (l_longest_string)
				l_font_height := l_font_height + one
			end
				-- Draw each line of text using calcs above
			across
				l_list as ic
			from
				l_this_top := a_widget.height - ( l_list.count * (l_font_height + padding_and_border_pixels) )
				l_this_top := l_this_top // mod_two
			loop
				a_widget.set_font (l_font)
				if not ic.item [first_item].is_upper then
					l_indent := default_indent
				else
					l_indent := nothing
				end
				l_line := ic.item
				l_line.replace_substring_all (newline, empty_string)
				l_line.replace_substring_all (tab, empty_string)
				a_widget.set_foreground_color (colors.black)
				a_widget.draw_text_top_left (((a_widget.width - l_font_width) / half).truncated_to_integer + l_indent + text_offset, l_this_top + text_offset, l_line)
				a_widget.set_foreground_color (colors.white)
				a_widget.draw_text_top_left (((a_widget.width - l_font_width) / half).truncated_to_integer + l_indent, l_this_top, l_line)
				l_this_top := l_this_top + padding_and_border_pixels + l_font.height
			end
		end

feature -- Constants

	bottom_margin_height: INTEGER = 35
	colors: CNX_STOCK_COLORS
	default_indent: INTEGER
	double: INTEGER = 2
	eighty_percent: REAL = 0.80
	empty_string: STRING = ""
	first_item: INTEGER = 1
	half: INTEGER = 2
	margin: INTEGER = 20
	mod_two: INTEGER = 2
	newline: STRING = "%N"
	nothing: INTEGER = 0
	one: INTEGER = 1
	padding_and_border_pixels: INTEGER = 3
	pipe_char: CHARACTER = '|'
	tab: STRING = "%T"
	text_offset: INTEGER = 4

end
