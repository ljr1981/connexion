note
	description: "[
		Representation of a Connexion Service (Announcements, Songs, Notes)
		]"

class
	CNX_SERVICE

inherit
	JSON_SERIALIZABLE

	JSON_DESERIALIZABLE

create
	default_create,
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

				-- Announcements
			if attached {JSON_ARRAY} json_object_to_json_array ("announcements", l_object) as al_array then
				across
					al_array as ic
				loop
					if attached {JSON_OBJECT} ic.item as al_item then
						announcements.force (create {CNX_POEM}.make_from_json (al_item.representation))
					end
				end
			end
				-- Songs
			if attached {JSON_ARRAY} json_object_to_json_array ("songs", l_object) as al_array then
				across
					al_array as ic
				loop
					if attached {JSON_OBJECT} ic.item as al_item then
						songs.force (create {CNX_POEM}.make_from_json (al_item.representation))
					end
				end
			end
				-- Notes
			if attached {JSON_ARRAY} json_object_to_json_array ("notes", l_object) as al_array then
				across
					al_array as ic
				loop
					if attached {JSON_OBJECT} ic.item as al_item then
						notes.force (create {CNX_POEM}.make_from_json (al_item.representation))
					end
				end
			end
		end

feature -- JSON

	convertible_features (a_current: ANY): ARRAY [STRING]
			-- <Precursor>
		once
			Result := <<
						"announcements",
						"songs",
						"notes"
					>>
		end

	metadata_refreshed (a_current: ANY): ARRAY [JSON_METADATA]
			-- <Precursor>
		do
			Result := <<
						create {JSON_METADATA}.make_text ("announcements", ""),
						create {JSON_METADATA}.make_text ("songs", ""),
						create {JSON_METADATA}.make_text ("notes", "")
						>>
		end

feature -- Access

	announcements: ARRAYED_LIST [CNX_POEM]
		attribute
			create Result.make (10)
		end

	songs: ARRAYED_LIST [CNX_POEM]
		attribute
			create Result.make (10)
		end

	notes: ARRAYED_LIST [CNX_POEM]
		attribute
			create Result.make (10)
		end

end
