note
	description: "[
		Representation of a Stanza
		]"

class
	CNX_STANZA

create
	make

feature {NONE} -- Initialization

	make (a_number: like number; a_type: like type; a_text: like text)
		do
			number := a_number
			type := a_type
			text := a_text
		ensure
			number_set: number = a_number
			type_set: type.same_string (a_type)
			text_set: text.same_string (a_text)
		end

feature -- Access

	number: INTEGER

	type: STRING_32
		attribute
			Result := constants.verse_type_tag
		end

	text: STRING_32
		attribute
			create Result.make_empty
		end

feature {NONE} -- Implementation

	constants: CNX_CONSTANTS
		once
			create Result
		end

invariant
	valid_type: constants.stanza_types.has (type)

end
