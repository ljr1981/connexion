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

	bottom_margin_height: INTEGER = 35
	colors: CNX_STOCK_COLORS once create Result end
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
