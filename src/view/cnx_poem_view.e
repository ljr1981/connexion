note
	description: "[
		Representation of a Connexion Poem View
		]"
	design: "[
		Horizontal_view ::=
			Tree_list_of_poems
			Poem_detail_view
		]"

class
	CNX_POEM_VIEW

inherit
	CNX_PLAIN_HORIZONTAL_BOX_WIDGET
		redefine
			default_create
		end

create
	default_create,
	make_with_poems

feature -- GUI Bits: Access

feature {NONE} -- GUI Bits

	poem_list_view: EV_VERTICAL_BOX
	poem_list_label: EV_LABEL
	poem_list: MVC_TREE

	detail_view: CNX_POEM_DETAIL_VIEW

feature {NONE} -- Initialization

	make_with_poems (a_poems: ARRAY [CNX_POEM])
		do
			default_create
		end

	default_create
			-- <Precursor>
		do
			create poem_list_view
			create poem_list_label.make_with_text ("Items: ")
			create poem_list
			create detail_view

			Precursor

			initialize

		end

	initialize
		do
			--	Horizontal_view ::= *Current or Current.widget
			--		Poem_list_view
			--		Poem_detail_view
			--
			-- 	Poem_list_view ::=
			-- 		Poem_list_label
			--		Poem_list
			widget.extend (poem_list_view)
				poem_list_view.extend (poem_list_label)
				poem_list_view.extend (poem_list.view)
			widget.extend (detail_view.widget)

				-- Disables
			poem_list_view.disable_item_expand (poem_list_label)

				-- Settings
			poem_list_label.align_text_left

				-- Padding & Borders
			poem_list_view.set_padding (3)
			poem_list_view.set_border_width (3)

				-- Other
		end

end
