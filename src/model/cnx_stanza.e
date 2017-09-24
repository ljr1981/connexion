note
	description: "[
		Representation of a Stanza
		]"

class
	CNX_STANZA

inherit
	JSON_SERIALIZABLE

	JSON_DESERIALIZABLE

create
	make,
	make_from_json

feature {NONE} -- Initialization

	make_from_json (a_json: STRING)
			-- <Precursor>
		require else											-- This must be here because the ancestor is False.
			True												--	Leaving it False, will cause this to fail.
		local
			l_object: detachable JSON_OBJECT					-- You must have one of these because ...
			l_any: detachable ANY
		do
			l_object := json_string_to_json_object (a_json)		-- ... the JSON string is parsed to a JSON_OBJECT.
			check attached_object: attached l_object end		-- This proves that our JSON parsing was okay.

			number := json_object_to_integer ("number", l_object)
			text := json_object_to_json_string_representation_attached ("text", l_object)
			type := json_object_to_json_string_representation_attached ("type", l_object)
		end

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

feature -- JSON

	convertible_features (a_current: ANY): ARRAY [STRING]
			-- <Precursor>
		once
			Result := <<
						"number",
						"type",
						"text"
					>>
		end

	metadata_refreshed (a_current: ANY): ARRAY [JSON_METADATA]
			-- <Precursor>
		do
			Result := <<
						create {JSON_METADATA}.make_number ("number", 1, 1000, 1),
						create {JSON_METADATA}.make_text ("type", ""),
						create {JSON_METADATA}.make_text ("text", "")
						>>
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
