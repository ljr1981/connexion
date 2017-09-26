deferred class
	MVC_MODEL [G]

feature -- Access: Text

	text: detachable STRING_32

feature -- Ops: Text

	wipe_out
		do
			if attached text as al_text then
				al_text.wipe_out
			end
		end

	remove_text
		do
			text := Void
		end

feature -- Setters: Text

	set_text (a_text: attached like text)
		do
			text := a_text
		ensure
			set: attached text as al_text and then al_text.same_string (a_text)
		end

feature -- Access: Data Payload

	data_payload_item: detachable G

	attached_data_payload_item: G
		do
			check attached data_payload_item as al_item then Result := al_item end
		end

feature -- Ops: Data Payload

	remove_data_payload
		do
			data_payload_item := removal_version_of_data_payload_item
		end

	removal_version_of_data_payload_item: detachable G

feature -- Setters: Data Payload

	set_data_payload_item (a_item: G)
		do
			data_payload_item := a_item
		end

invariant
	never_attached: not attached removal_version_of_data_payload_item

end
