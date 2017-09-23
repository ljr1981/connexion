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
		do
			create Result.make (2)
			Result.force (chorus_type_tag, chorus_type_tag)
			Result.force (verse_type_tag, verse_type_tag)
		end

end
