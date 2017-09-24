note
	description: "Tests of {CONNEXION}."
	testing: "type/manual"

class
	CONNEXION_TEST_SET

inherit
	EQA_TEST_SET
		rename
			assert as assert_old
		end

	EQA_COMMONLY_USED_ASSERTIONS
		undefine
			default_create
		end

	TEST_SET_BRIDGE
		undefine
			default_create
		end

feature -- Test routines

	CONNEXION_tests
			-- `CONNEXION_tests'
		local
			l_song: CNX_POEM
		do
			create l_song.make_with_title ("How Great Thou Art")
			across
				how_great_thou_art.split ('%N') as ic_song_text
			loop
				if ic_song_text.cursor_index = 1 then
					l_song.stanzas.force (create {CNX_STANZA}.make (1, {CNX_CONSTANTS}.chorus_type_tag, ic_song_text.item))
				else
					l_song.stanzas.force (create {CNX_STANZA}.make (ic_song_text.cursor_index - 1, {CNX_CONSTANTS}.verse_type_tag, ic_song_text.item))
				end
			end
			assert_integers_equal ("chorus_count", 1, l_song.chorus_count)
			assert_integers_equal ("verse_count", 3, l_song.verse_count)
		end

	esc_utf8_test
		local
			l_converter: UTF_CONVERTER
			l_result: STRING_32
		do
			create l_converter
			create l_result.make_empty
			l_result := l_converter.utf_8_string_8_to_string_32 (l_converter.escaped_utf_32_string_to_utf_8_string_8 (esc_utf8))
			assert_strings_equal ("conv", {STRING_32} "כי ככה", l_result)
		end

feature {NONE} -- Data

	esc_utf8: STRING_8
		local
			l_converter: UTF_CONVERTER
		once
			create l_converter
			create Result.make_empty
			Result.append_string_general (l_converter.utf_8_bom_to_string_8)
			Result.append_string_general ("\u05DB\u05D9 \u05DB\u05DB\u05D4")
		end

	how_great_thou_art: STRING = "[
Then sings my soul|My Savior, God, to Thee|How great thou art|How great thou art|Then sings my soul|My Savior, God, to Thee|How great Thou art|How great Thou art
Oh Lord my God|When I in awesome wonder|Consider all the worlds|Thy hands have made|I see the stars|I hear the rolling thunder|Thy power throughout|The universe displayed
And when I think of God,|His son not sparing,|Sent Him to die,|I scarce can take it in;|That on the cross, my burden|gladly bearing He bled and died|to take away my sin
When Christ shall come|With shout of acclamation|And take me home|What joy shall fill my heart|Then I shall bow|With humble adoration|And then proclaim My God|How great Thou art
]"

end
