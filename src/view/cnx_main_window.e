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
			initialize
		end

create
	make_with_title

feature {NONE} -- GUI

	display_window: CNX_DISPLAY_WINDOW

feature {NONE} -- GUI bits

	main_box: CNX_PLAIN_HORIZONTAL_BOX_WIDGET -- ::=

		list_box: CNX_PLAIN_VERTICAL_BOX_WIDGET -- ::=

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
			create display_window.make_with_title ("Display")

			create main_box
				create list_box
					create announcement_list.make ("Announcements")
					create song_list.make ("Songs")
					create notes_list.make ("Notes")
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
		do
			display_window.set_size (800, 600)
			close_request_actions.extend (agent display_window.destroy)

			display_window.show

				-- Stuff inside main_box

				-- Extensions
			main_box.widget.extend (list_box.widget)
				list_box.widget.extend (announcement_list.widget)
				list_box.widget.extend (song_list.widget)
				list_box.widget.extend (notes_list.widget)

			main_box.widget.extend (prev_disp_vbox.widget)

			prev_disp_vbox.widget.extend (preview_box.widget)
				preview_box.widget.extend (center_large.widget)
			prev_disp_vbox.widget.extend (display_box.widget)
				display_box.widget.extend (create {EV_CELL})
				display_box.widget.extend (display_large.widget)
				display_box.widget.extend (create {EV_CELL})

				-- Disables

				-- Settings
			display_box.widget.set_minimum_width (500)
			display_large.enable_blanking
			display_large.set_display_target (display_window)

				-- Borders & Padding

				-- Other Misc

				-- Extension to main
			extend (main_box.widget)

			Precursor

			load_songs
		end

feature -- Hand-loaded

	load_songs
		do
			across
				songs as ic
			loop
				load_song (ic.item)
			end
		end

	load_song (a_song: CNX_SONG)
		local
			l_tree_song,
			l_tree_stanza: EV_TREE_ITEM
			l_song: CNX_SONG
			l_stanza: CNX_STANZA
		do
			create l_tree_song.make_with_text (a_song.title)
				song_list.list.extend (l_tree_song)
					across
						a_song.stanzas as ic
					loop
						create l_tree_stanza.make_with_text (ic.item.type + ic.item.number.out + " - " + ic.item.text)
						l_tree_song.extend (l_tree_stanza)

						l_tree_stanza.select_actions.extend (agent on_stanza_select (ic.item))
						l_tree_stanza.pointer_double_press_actions.extend (agent on_stanza_double_click (?, ?, ?, ?, ?, ?, ?, ?, ic.item))
					end
		end

	on_stanza_key_press (a_key: EV_KEY; a_stanza: CNX_STANZA)
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_enter then
				center_large.on_blank_click
				center_large.on_set_stanza (a_stanza)
				center_large.on_move
			end
		end

	on_stanza_select (a_stanza: CNX_STANZA)
		do
			center_large.on_blank_click
			center_large.on_set_stanza (a_stanza)
			song_list.list.key_press_actions.extend_kamikaze (agent on_stanza_key_press (?, a_stanza))
		end

	on_stanza_double_click (a_x, a_y, a_button: INTEGER_32; a_x_tilt, a_y_tilt, a_pressure: REAL_64; a_screen_x, a_screen_y: INTEGER_32; a_stanza: CNX_STANZA)
		do
			center_large.on_blank_click
			center_large.on_set_stanza (a_stanza)
			center_large.on_move
		end

feature {NONE} -- Data

	songs: ARRAYED_LIST [CNX_SONG]
		attribute
			create Result.make (20)
			Result.force (how_great_thou_art)
			Result.force (amazing_grace)
		end

	how_great_thou_art: CNX_SONG
		once
			create Result.make_with_title ("How Great Thou Art")
			across
				how_great_thou_art_words.split ('%N') as ic_song_text
			loop
				if ic_song_text.cursor_index = 1 then
					Result.stanzas.force (create {CNX_STANZA}.make (1, {CNX_CONSTANTS}.chorus_type_tag, ic_song_text.item))
				else
					Result.stanzas.force (create {CNX_STANZA}.make (ic_song_text.cursor_index - 1, {CNX_CONSTANTS}.verse_type_tag, ic_song_text.item))
				end
			end
		end

	how_great_thou_art_words: STRING = "[
Then sings my soul|My Savior, God, to Thee|How great thou art|How great thou art|Then sings my soul|My Savior, God, to Thee|How great Thou art|How great Thou art
Oh Lord my God|When I in awesome wonder|Consider all the worlds|Thy hands have made|I see the stars|I hear the rolling thunder|Thy power throughout|The universe displayed
And when I think of God,|His son not sparing,|Sent Him to die,|I scarce can take it in;|That on the cross, my burden|gladly bearing He bled and died|to take away my sin
When Christ shall come|With shout of acclamation|And take me home|What joy shall fill my heart|Then I shall bow|With humble adoration|And then proclaim My God|How great Thou art
]"

	amazing_grace: CNX_SONG
		once
			create Result.make_with_title ("Amazing Grace")
			across
				amazing_grace_words.split ('%N') as ic_song_text
			loop
				if ic_song_text.cursor_index = 1 then
					Result.stanzas.force (create {CNX_STANZA}.make (1, {CNX_CONSTANTS}.chorus_type_tag, ic_song_text.item))
				else
					Result.stanzas.force (create {CNX_STANZA}.make (ic_song_text.cursor_index - 1, {CNX_CONSTANTS}.verse_type_tag, ic_song_text.item))
				end
			end
		end

	amazing_grace_words: STRING = "[
Amazing grace|How sweet the sound|That saved a wretch like me|I once was lost, but now I'm found|Was blind, but now I see
'Twas grace that taught|my heart to fear|And grace my|fears relieved|How precious did|that grace appear|The hour I|first believed
My chains|are gone|I've been|set free|My God, my Savior|has ransomed me|And like a flood|His mercy rains|Unending love,|Amazing grace
The Lord has|promised good to me|His word my|hope secures|He will my|shield and portion be|As long as|life endures
The earth shall|soon dissolve like snow|The sun forbear|to shine|But God, Who|called me here below|Will be|forever mine
]"

end
