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

feature -- Access

	stanza: detachable CNX_STANZA

feature {NONE} -- GUI Bits

	title_label_field: EV_HORIZONTAL_BOX
	title_label: EV_LABEL
	title_field: MVC_TEXT_FIELD

	stanza_list_view: EV_VERTICAL_BOX

	stanza_list: MVC_TREE
	stanza_list_label: EV_LABEL
	stanza_detail_view: EV_VERTICAL_BOX

	stanza_type_label_field: EV_HORIZONTAL_BOX
	stanza_type_label: EV_LABEL
	stanza_type_field: MVC_TEXT_FIELD
	stanza_number_label_field: EV_HORIZONTAL_BOX
	stanza_number_label: EV_LABEL
	stanza_number_field: MVC_TEXT_FIELD
	stanza_text_label_field: EV_VERTICAL_BOX
	stanza_text_label: EV_LABEL
	stanza_text_field: MVC_RICH_TEXT

feature {NONE} -- Initialization

	make_with_poem (a_poem: CNX_POEM)
		do
			default_create
			create detail_item.make_with_model (a_poem.title)
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
			create stanza_list_label.make_with_text ("Stanzas: ")
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
			title_label_field.extend (title_field.view)

		widget.extend (stanza_list_view)
			stanza_list_view.extend (stanza_list_label)
			stanza_list_view.extend (stanza_list.view)
			stanza_list_view.extend (stanza_detail_view)

		stanza_detail_view.extend (stanza_type_label_field)
			stanza_type_label_field.extend (stanza_type_label)
			stanza_type_label_field.extend (stanza_type_field.view)

		stanza_detail_view.extend (stanza_number_label_field)
			stanza_number_label_field.extend (stanza_number_label)
			stanza_number_label_field.extend (stanza_number_field.view)

		stanza_detail_view.extend (stanza_text_label_field)
			stanza_text_label_field.extend (stanza_text_label)
			stanza_text_label_field.extend (stanza_text_field.view)

			-- Disables
		widget.disable_item_expand (title_label_field)

		title_label_field.disable_item_expand (title_label)

		stanza_list_view.disable_item_expand (stanza_list_label)

		stanza_detail_view.disable_item_expand (stanza_type_label_field)
		stanza_detail_view.disable_item_expand (stanza_number_label_field)

		stanza_type_label_field.disable_item_expand (stanza_type_label)
		stanza_number_label_field.disable_item_expand (stanza_number_label)
		stanza_text_label_field.disable_item_expand (stanza_text_label)

			-- Settings
		title_label.align_text_left
		stanza_list_label.align_text_left
		stanza_type_label.align_text_left
		stanza_number_label.align_text_left
		stanza_text_label.align_text_left

			-- Paddings & Borders
		title_label_field.set_padding (3)
		title_label_field.set_border_width (3)

		stanza_list_view.set_padding (3)
		stanza_list_view.set_border_width (3)

		stanza_type_label_field.set_padding (3)
		stanza_type_label_field.set_border_width (3)

		stanza_number_label_field.set_padding (3)
		stanza_number_label_field.set_border_width (3)

		stanza_text_label_field.set_padding (3)
		stanza_text_label_field.set_border_width (3)

		end

feature -- Access

	detail_item: detachable MVC_TREE_ITEM
			-- The `detail_item' being presented.

end
