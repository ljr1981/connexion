note
	description: "[
		Representation of a Song.
		]"

class
	CNX_POEM

create
	make_with_title

feature {NONE} -- Initialization

	make_with_title (a_title: like title)
			--
		do
			title := a_title
		ensure
			set: title.same_string (a_title)
		end

feature -- Access

	title: STRING_32

	stanzas: ARRAYED_LIST [CNX_STANZA]
			-- `stanzas' of Current {CNX_POEM}.
		attribute
			create Result.make (5)
		end

feature -- Queries

	chorus_count: INTEGER
		do
			Result := stanza_type_count (constants.chorus_type_tag)
		end

	verse_count: INTEGER
		do
			Result := stanza_type_count (constants.verse_type_tag)
		end

	stanza_type_count (a_type: STRING): INTEGER
		do
			across
				stanzas as ic
			loop
				if ic.item.type.same_string (a_type) then
					Result := Result + 1
				end
			end
		end

feature {NONE} -- Implementation

	constants: CNX_CONSTANTS
		once
			create Result
		end

end
