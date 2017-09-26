class
	CNX_SERVICE_EDIT_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize
		end

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_data: detachable TUPLE [title: STRING_32; date: DATE_TIME])
		do
			if attached a_data as al_data then
				make_with_title ("Edit Service")
				service_title := a_data.title
				service_date := a_data.date
			else
				make_with_title ("New Service")
			end
		end

	service_title_field: EV_TEXT_FIELD attribute create Result.make_with_text ("Untitled") end
	service_title_mask: STRING_VALUE_INPUT_MASK attribute create Result.make_repeating ("K") end

	service_date_field: EV_TEXT_FIELD attribute create Result end
	service_date_mask: DATE_TIME_INPUT_MASK attribute create Result.make_month_day_year end

	initialize
			-- <Precursor>
		local
			l_vbox: EV_VERTICAL_BOX
			l_hbox: EV_HORIZONTAL_BOX
			l_label: EV_LABEL
		do
			Precursor
			set_size (300, 200)
			create l_vbox
				create l_hbox
				l_vbox.extend (l_hbox)
					create l_label.make_with_text ("Service title: ")
					l_hbox.extend (l_label)
					l_hbox.extend (service_title_field)
					service_title_mask.initialize_masking_widget_events (service_title_field)
					service_title_field.set_text (service_title_mask.apply (service_title).masked_string)
					service_title_field.focus_in_actions.extend (agent service_title_field.select_all)
					service_title_field.focus_out_actions.extend (agent on_service_title_set)
					l_hbox.set_padding (3)
					l_hbox.set_border_width (3)
				l_vbox.disable_item_expand (l_hbox)
				create l_hbox
				l_vbox.extend (l_hbox)
					create l_label.make_with_text ("Service date: ")
					l_hbox.extend (l_label)
					l_hbox.extend (service_date_field)
					service_date_mask.initialize_masking_widget_events (service_date_field)
					service_date_field.set_text (service_date_mask.apply (service_date).masked_string)
					service_date_field.focus_in_actions.extend (agent service_date_field.select_all)
					service_date_field.focus_out_actions.extend (agent on_service_date_set)
					l_hbox.set_padding (3)
					l_hbox.set_border_width (3)
				l_vbox.disable_item_expand (l_hbox)
				create l_hbox
					l_hbox.extend (create {EV_BUTTON}.make_with_text_and_action ("OK", agent on_ok))
					l_hbox.extend (create {EV_BUTTON}.make_with_text_and_action ("Cancel", agent on_cancel))
					l_hbox.set_padding (3)
					l_hbox.set_border_width (3)
				l_vbox.extend (l_hbox)
				l_vbox.disable_item_expand (l_hbox)
				l_vbox.set_padding (3)
				l_vbox.set_border_width (3)
			extend (l_vbox)
		end

feature -- Access

	service_title: STRING_32
		attribute
			Result := {STRING_32} "Untitled"
		end

	on_service_title_set
		do

		end

	service_date: DATE_TIME
		attribute
			create Result.make_now
		end

	on_service_date_set
		do

		end

	is_ok: BOOLEAN

	on_ok
		local
			l_date: DATE
		do
			if
				attached {LIST [STRING_32]} service_date_field.text.split ('/') as al_list and then
				al_list.count = 3 and then
				al_list [1].is_integer and then
				al_list [2].is_integer and then
				al_list [3].is_integer
			then
				service_title := service_title_field.text
				create l_date.make (al_list [3].to_integer, al_list [1].to_integer, al_list [2].to_integer)
				service_date := create {DATE_TIME}.make_by_date (l_date)
				is_ok := True
			else
				is_ok := False
			end
			destroy
		end

	on_cancel
		do
			is_ok := False
			destroy
		end

end
