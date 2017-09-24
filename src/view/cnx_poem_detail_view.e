note
	description: "[
		Representation of a Connexion Poem Detail View
		]"
	design: "[
		Vertical_view ::=
			Title_label_and_field
			Stanza_list_view
		
		Stanza_list_view ::=
			Stanza_list
			Stanza_detail_view
			
		Stanza_detail_view ::=
			Stanza_type_label_and_field
			Stanza_number_label_and_field
			Stanza_text_label_and_field
		]"

class
	CNX_POEM_DETAIL_VIEW

inherit
	CNX_PLAIN_VERTICAL_BOX_WIDGET
		redefine
			default_create
		end

create
	default_create,
	make_with_poem

feature -- GUI Bits: Access

feature {NONE} -- GUI Bits

	title_label_field: EV_HORIZONTAL_BOX
	title_label: EV_LABEL
	title_field: EV_TEXT_FIELD

	stanza_list_view: EV_VERTICAL_BOX

	stanza_list: EV_TREE
	stanza_detail_view: EV_VERTICAL_BOX

	stanza_type_label_field: EV_HORIZONTAL_BOX
	stanza_type_label: EV_LABEL
	stanza_type_field: EV_TEXT_FIELD
	stanza_number_label_field: EV_HORIZONTAL_BOX
	stanza_number_label: EV_LABEL
	stanza_number_field: EV_TEXT_FIELD
	stanza_text_label_field: EV_HORIZONTAL_BOX
	stanza_text_label: EV_LABEL
	stanza_text_field: EV_TEXT_FIELD

feature {NONE} -- Initialization

	make_with_poem (a_poem: CNX_POEM)
		do
			default_create
		end

	default_create
			-- <Precursor>
		do
			--	Vertical_view ::= *Current or Current.widget
			--		Title_label_and_field
			--		Stanza_list_view
			create title_label_field
			create title_label.make_with_text ("Title: ")
			create title_field

			--	Stanza_list_view ::=
			--		Stanza_list
			--		Stanza_detail_view
			create stanza_list_view
			create stanza_list
			create stanza_detail_view

			--	Stanza_detail_view ::=
			--		Stanza_type_label_and_field
			--		Stanza_number_label_and_field
			--		Stanza_text_label_and_field
			create stanza_type_label_field
			create stanza_type_label.make_with_text ("Type: ")
			create stanza_type_field

			create stanza_number_label_field
			create stanza_number_label.make_with_text ("Number: ")
			create stanza_number_field

			create stanza_text_label_field
			create stanza_text_label.make_with_text ("Text: ")
			create stanza_text_field

			Precursor

			initialize

		end

	initialize
		do
			-- Extensions
		widget.extend (title_label_field)
			title_label_field.extend (title_label)
			title_label_field.extend (title_field)

		widget.extend (stanza_list_view)
			stanza_list_view.extend (stanza_list)
			stanza_list_view.extend (stanza_detail_view)

		stanza_detail_view.extend (stanza_type_label_field)
			stanza_type_label_field.extend (stanza_type_label)
			stanza_type_label_field.extend (stanza_type_field)

		stanza_detail_view.extend (stanza_number_label_field)
			stanza_type_label_field.extend (stanza_number_label)
			stanza_type_label_field.extend (stanza_number_field)

		stanza_detail_view.extend (stanza_text_label_field)
			stanza_type_label_field.extend (stanza_text_label)
			stanza_type_label_field.extend (stanza_text_field)

			-- Disables
			-- Settings
			-- Paddings & Borders
		end

end
