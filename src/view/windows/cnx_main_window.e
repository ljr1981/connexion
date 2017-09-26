note
	description: "[
		Representation of the Main Window for Connexion.
		]"

class
	CNX_MAIN_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			create_interface_objects,
			initialize,
			is_in_default_state
		end

create
	make_with_title

feature {NONE} -- GUI

	display_window: CNX_DISPLAY_WINDOW

feature {NONE} -- GUI bits

	main_box: CNX_PLAIN_HORIZONTAL_BOX_WIDGET -- ::=

		notebook: EV_NOTEBOOK
			service_tab: CNX_PLAIN_HORIZONTAL_BOX_WIDGET
			announcements_tab,
			songs_tab,
			notes_tab: CNX_PLAIN_HORIZONTAL_BOX_WIDGET

			announcement_view,
			song_view,
			notes_view: CNX_POEM_VIEW

		list_box: CNX_PLAIN_VERTICAL_BOX_WIDGET -- ::=

			service_title_label: EV_LABEL
			service_date_label: EV_LABEL

			service_title_field: EV_TEXT_FIELD attribute create Result.make_with_text ("Untitled") end
			service_title_mask: STRING_VALUE_INPUT_MASK attribute create Result.make_repeating ("K") end

			service_date_field: EV_TEXT_FIELD attribute create Result end
			service_date_mask: DATE_TIME_INPUT_MASK attribute create Result.make_month_day_year end

			announcement_list,
			song_list,
			notes_list: CNX_ITEM_LIST

		prev_disp_vbox: CNX_PLAIN_VERTICAL_BOX_WIDGET -- ::=

			preview_box: CNX_PLAIN_VERTICAL_BOX_WIDGET -- ::=
				center_large: CNX_LARGE_PREVIEW_ITEM

			display_box: CNX_PLAIN_VERTICAL_BOX_WIDGET -- ::=
				display_large: CNX_LARGE_PREVIEW_ITEM

feature {NONE} -- Initialization

	create_interface_objects
			-- <Precursor>
		do
			create display_window.make_with_title (constants.display_window_title)

			create main_box
				create notebook
					create service_tab
					notebook.extend (service_tab.widget)
					notebook.item_tab (service_tab.widget).set_text ("Service")
					create announcements_tab
					notebook.extend (announcements_tab.widget)
					notebook.item_tab (announcements_tab.widget).set_text ("Announcements")
					create songs_tab
					notebook.extend (songs_tab.widget)
					notebook.item_tab (songs_tab.widget).set_text ("Songs")
					create notes_tab
					notebook.extend (notes_tab.widget)
					notebook.item_tab (notes_tab.widget).set_text ("Notes")

					create announcement_view
					create song_view
					create notes_view

				create list_box
					create service_title_label.make_with_text ("Title: ")
					create service_date_label.make_with_text ("Date: ")
					create announcement_list.make (constants.announcements_label_text)
					create song_list.make (constants.songs_list_label_text)
					create notes_list.make (constants.notes_list_label_text)
				create prev_disp_vbox
				create preview_box
					-- creations are below because we need the `display_large' creation first.
				create display_box
					create display_large
					create center_large.make_with_preview_target (display_large)

			Precursor
		end

	initialize
			-- <Precursor>
		local
			l_menu_bar: EV_MENU_BAR
			l_menu: EV_MENU
			l_menu_item: EV_MENU_ITEM
		do
			display_window.set_size (constants.default_window_width, constants.default_window_height)
			close_request_actions.extend (agent display_window.destroy)

			display_window.show

				-- Stuff inside main_box

				-- Extensions
			create l_menu_bar
			set_menu_bar (l_menu_bar)
			create l_menu.make_with_text ("File")
			l_menu_bar.extend (l_menu)
			create l_menu_item.make_with_text_and_action ("New Service", agent on_new_service)
			l_menu.extend (l_menu_item)

			main_box.widget.extend (notebook)
			service_tab.widget.extend (list_box.widget)
				list_box.widget.extend (service_title_label)
				list_box.widget.extend (service_title_field)
					service_title_mask.initialize_masking_widget_events (service_title_field)
					service_title_field.set_text (service_title_mask.apply (service_title).masked_string)
					service_title_field.focus_in_actions.extend (agent service_title_field.select_all)
					service_title_field.focus_out_actions.extend (agent on_service_title_set)
				list_box.widget.extend (service_date_label)
				list_box.widget.extend (service_date_field)
					service_date_mask.initialize_masking_widget_events (service_date_field)
					service_date_field.set_text (service_date_mask.apply (service_date).masked_string)
					service_date_field.focus_in_actions.extend (agent service_date_field.select_all)
					service_date_field.focus_out_actions.extend (agent on_service_date_set)
				list_box.widget.extend (announcement_list.widget)
				list_box.widget.extend (song_list.widget)
				list_box.widget.extend (notes_list.widget)

			service_tab.widget.extend (prev_disp_vbox.widget)
			announcements_tab.widget.extend (announcement_view.widget)
			songs_tab.widget.extend (song_view.widget)
			notes_tab.widget.extend (notes_view.widget)

			prev_disp_vbox.widget.extend (preview_box.widget)
				preview_box.widget.extend (center_large.widget)
			prev_disp_vbox.widget.extend (display_box.widget)
				display_box.widget.extend (create {EV_CELL})
				display_box.widget.extend (display_large.widget)
				display_box.widget.extend (create {EV_CELL})

				-- Disables
			list_box.widget.disable_item_expand (service_title_label)
			list_box.widget.disable_item_expand (service_title_field)
			service_title_field.disable_edit
			list_box.widget.disable_item_expand (service_date_label)
			list_box.widget.disable_item_expand (service_date_field)
			service_date_field.disable_edit

				-- Settings
			service_title_label.align_text_left
			service_date_label.align_text_left
			display_box.widget.set_minimum_width (constants.default_window_width_minimum)
			display_large.enable_blanking
			display_large.set_display_target (display_window)

				-- Borders & Padding

				-- Other Misc

				-- Extension to main
			extend (main_box.widget)

			Precursor

--			load_songs
--			load_notes
		end

	is_in_default_state: BOOLEAN
		do
			Result := True
		end

feature -- Loading

	load_songs
		local
			l_json_string: STRING_32
			l_title: STRING
			l_file: PLAIN_TEXT_FILE
		do
			load_list (songs, song_list)
		end

	load_notes
		local
			l_json_string: STRING_32
			l_title: STRING
			l_file: PLAIN_TEXT_FILE
		do
			load_list (notes, notes_list)
		end

	load_list (a_list: ARRAYED_LIST [CNX_POEM]; a_item_list: CNX_ITEM_LIST)
		do
			across a_list as ic loop load_list_item (ic.item, a_item_list) end
		end

	load_list_item (a_item: CNX_POEM; a_item_list: CNX_ITEM_LIST)
		local
			l_tree_poem,
			l_tree_stanza: EV_TREE_ITEM
		do
			create l_tree_poem.make_with_text (a_item.title)
				a_item_list.list.extend (l_tree_poem)
					across
						a_item.stanzas as ic
					loop
						create l_tree_stanza.make_with_text (ic.item.type + ic.item.number.out + constants.space_delimited_dash_string + ic.item.text)
						l_tree_poem.extend (l_tree_stanza)

						l_tree_stanza.select_actions.extend (agent on_stanza_select (ic.item, a_item))
						l_tree_stanza.pointer_double_press_actions.extend (agent on_stanza_double_click (?, ?, ?, ?, ?, ?, ?, ?, ic.item, a_item))
					end
		end

feature -- Events: Menu

	on_new_service
		local
			l_dialog: CNX_SERVICE_EDIT_DIALOG
		do
			create l_dialog.make_with_data (Void)
			l_dialog.show_modal_to_window (Current)
			if l_dialog.is_ok then
				create current_service.make_with_title (l_dialog.service_title, l_dialog.service_date.date)
				if attached current_service as al_service then
						-- Title & Date
					service_title := al_service.title
					service_title_field.set_text (al_service.title)
					create service_date.make_by_date (al_service.date)
					service_date_field.set_text (al_service.date.out)
						-- Announcements
					announcement_list.list.wipe_out
						-- Songs
					songs.wipe_out
					song_list.list.wipe_out
						-- Notes
					notes.wipe_out
					notes_list.list.wipe_out
				end
			end
		end

	current_service: detachable CNX_SERVICE

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

feature -- Events

	on_stanza_key_press (a_key: EV_KEY; a_stanza: CNX_STANZA; a_poem: CNX_POEM)
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_enter then
				center_large.on_blank_click
				center_large.on_set_stanza (a_stanza, a_poem)
				center_large.on_move
			end
		end

	on_stanza_select (a_stanza: CNX_STANZA; a_poem: CNX_POEM)
		do
			center_large.on_blank_click
			center_large.on_set_stanza (a_stanza, a_poem)
			song_list.list.key_press_actions.extend_kamikaze (agent on_stanza_key_press (?, a_stanza, a_poem))
		end

	on_stanza_double_click (a_x, a_y, a_button: INTEGER_32; a_x_tilt, a_y_tilt, a_pressure: REAL_64; a_screen_x, a_screen_y: INTEGER_32; a_stanza: CNX_STANZA; a_poem: CNX_POEM)
		do
			center_large.on_blank_click
			center_large.on_set_stanza (a_stanza, a_poem)
			center_large.on_move
		end

feature {NONE} -- Constants

	constants: CNX_CONSTANTS once create Result end

feature {NONE} -- Data

	notes: ARRAYED_LIST [CNX_POEM]
		attribute
			create Result.make (20)
			Result.force (john_3_16)
			Result.force (john_3_16_hebrew)
		end

	songs: ARRAYED_LIST [CNX_POEM]
		attribute
			create Result.make (20)
			Result.force (how_great_thou_art)
			Result.force (amazing_grace)
		end

	how_great_thou_art: CNX_POEM
		once
			create Result.make_from_json (how_great_thou_art_json)
		end

	how_great_thou_art_json: STRING = "[
{"title":"How Great Thou Art","stanzas":[{"type":"chorus","text":"Then sings my soul|My Savior, God, to Thee|How great thou art|How great thou art|Then sings my soul|My Savior, God, to Thee|How great Thou art|How great Thou art","number":1},{"type":"verse","text":"Oh Lord my God|When I in awesome wonder|Consider all the worlds|Thy hands have made|I see the stars|I hear the rolling thunder|Thy power throughout|The universe displayed","number":1},{"type":"verse","text":"And when I think of God,|His son not sparing,|Sent Him to die,|I scarce can take it in;|That on the cross, my burden|gladly bearing|He bled and died|to take away my sin","number":2},{"type":"verse","text":"When Christ shall come|With shout of acclamation|And take me home|What joy shall fill my heart|Then I shall bow|With humble adoration|And then proclaim My God|How great Thou art","number":3}]}
]"

	amazing_grace: CNX_POEM
		once
			create Result.make_from_json (amazing_grace_json)
		end

	amazing_grace_json: STRING = "[
{"title":"Amazing Grace","stanzas":[{"type":"chorus","text":"Amazing grace|how sweet the sound|that saved a|wretch like me.|I once was lost, but now I'm found|Was blind, but now I see.","number":1},{"type":"verse","text":"Twas grace that taught|my heart to fear|And grace|my fears relieved!|How precious did|that grace appear|The hour I|first believed.","number":1},{"type":"verse","text":"My chains|are gone;|I've been|set free|My God, my Savior|has ransomed me|And like a flood,|His mercy rains|unending love,|Amazing grace","number":2},{"type":"verse","text":"The Lord has|promised good to me.|His word my|hope secures!|He will my|shield and portion be|as long as|life endures.","number":3},{"type":"verse","text":"The earth shall|soon dissolve like snow;|The sun forbear|to shine.|But God, Who|called me here below|will be|forever mine","number":4}]}
]"

	john_3_16: CNX_POEM
		once
			create Result.make_from_json (john_3_16_json)
		end

	john_3_16_json: STRING = "[
{"title":"John 3 16 KJV","stanzas":[{"type":"verse","text":"John 3:16 For God so loved the world,|that he gave his only begotten Son,|that whosoever believeth in him|should not perish,|but have everlasting life.","number":1}]}
]"

	john_3_16_hebrew: CNX_POEM
		once
			create Result.make_from_json (john_3_16_hebrew_json)
		end

	john_3_16_hebrew_json: STRING = "[
{"title":"John 3 16 KJV Hebrew","stanzas":[{"type":"verse","text":"\u05DB\u05D9 \u05DB\u05DB\u05D4 |\u05D0\u05D4\u05D1 \u05D4\u05D0\u05DC\u05D4\u05D9\u05DD |\u05D0\u05EA \u05D4\u05E2\u05D5\u05DC\u05DD \u05E2\u05D3 |\u05D0\u05E9\u05E8 \u05E0\u05EA\u05DF \u05D0\u05EA \u05D1\u05E0\u05D5 \u05D0\u05EA |\u05D9\u05D7\u05D9\u05D3\u05D5 \u05DC\u05DE\u05E2\u05DF \u05DC\u05D0 \u05D9\u05D0\u05D1\u05D3 |\u05DB\u05DC \u05D4\u05DE\u05D0\u05DE\u05D9\u05DF \u05D1\u05D5 \u05DB\u05D9 \u05D0\u05DD |\u05D9\u05D7\u05D9\u05D4 \u05D7\u05D9\u05D9 \u05E2\u05D5\u05DC\u05DE\u05D9\u05DD\u05C3","number":1}]}
]"

end
