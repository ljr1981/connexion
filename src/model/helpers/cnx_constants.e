note
	description: "[
		Constants
		]"

class
	CNX_CONSTANTS

feature -- Constants

	line_split_character: CHARACTER = '|'
	chorus_type_tag: STRING = "chorus"
	verse_type_tag: STRING = "verse"

	stanza_types: HASH_TABLE [STRING, STRING]
		once
			create Result.make (2)
			Result.force (chorus_type_tag, chorus_type_tag)
			Result.force (verse_type_tag, verse_type_tag)
		end

	announcements_label_text: STRING = "Accouncements"
	songs_list_label_text: STRING = "Songs"
	notes_list_label_text: STRING = "Notes"
	space_delimited_dash_string: STRING = " - "
	blank_title: STRING = "Blank"
	bottom_margin_height: INTEGER = 35
	colors: CNX_STOCK_COLORS once create Result end
	default_preview_size_width: INTEGER = 600
	default_preview_size_height: INTEGER = 450
	default_indent: INTEGER
	default_window_height: INTEGER = 600
	default_window_width: INTEGER = 800
	default_window_width_minimum: INTEGER = 500
	display_window_title: STRING = "Display"
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
