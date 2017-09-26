note
	description: "[
		Representation of a Song.
		]"

class
	CNX_POEM

inherit
	JSON_SERIALIZABLE

	JSON_DESERIALIZABLE

create
	make_with_title,
	make_from_json

feature {NONE} -- Initialization

	make_from_json (a_json: STRING)
			-- <Precursor>
		require else											-- This must be here because the ancestor is False.
			True												--	Leaving it False, will cause this to fail.
		local
			l_object: detachable JSON_OBJECT					-- You must have one of these because ...
			l_any: detachable ANY
			l_stanzas: JSON_FILLABLES [CNX_STANZA]
		do
			l_object := json_string_to_json_object (a_json)		-- ... the JSON string is parsed to a JSON_OBJECT.
			check attached_object: attached l_object end		-- This proves that our JSON parsing was okay.

			title := json_object_to_json_string_representation_attached ("title", l_object)
			if attached {JSON_ARRAY} json_object_to_json_array ("stanzas", l_object) as al_array then
				across
					al_array as ic
				loop
					if attached {JSON_OBJECT} ic.item as al_stanza_object then
						stanzas.force (create {CNX_STANZA}.make_from_json (al_stanza_object.representation))
					end
				end
			end
		end

	stanza_filler: JSON_FILLABLES [CNX_STANZA] once create Result end

	make_with_title (a_title: like title)
			--
		do
			title := a_title
		ensure
			set: title.same_string (a_title)
		end

feature -- JSON

	convertible_features (a_current: ANY): ARRAY [STRING]
			-- <Precursor>
		once
			Result := <<
						"title",
						"stanzas"
					>>
		end

	metadata_refreshed (a_current: ANY): ARRAY [JSON_METADATA]
			-- <Precursor>
		do
			Result := <<
						create {JSON_METADATA}.make_text ("title", ""),
						create {JSON_METADATA}.make_text ("stanzas", "")
						>>
		end

feature -- Access

	title: STRING_32

	stanzas: ARRAYED_LIST [CNX_STANZA]
			-- `stanzas' of Current {CNX_POEM}.
		attribute
			create Result.make (5)
		end

	stanza_hash: HASH_TABLE [CNX_STANZA, INTEGER]
			-- If `internal_stanza_hash' is still same, otherwise recompute it.
		do
			if
				internal_stanza_hash.count /= stanzas.count or else
				across stanzas as ic some
					not across internal_stanza_hash as ic_int some
							ic_int.item.text.hash_code /= ic.item.text.hash_code
						end
				end
			then
				create Result.make (stanzas.count)
				across
					stanzas as ic
				loop
					Result.force (ic.item, ic.item.text.hash_code)
				end
				internal_stanza_hash := Result
			else
				Result := internal_stanza_hash
			end
		end

	internal_stanza_hash: like stanza_hash
		attribute
			create Result.make (stanzas.count)
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
