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

	poem_list: EV_TREE

	detail_view: CNX_POEM_DETAIL_VIEW

feature {NONE} -- Initialization

	make_with_poems (a_poems: ARRAY [CNX_POEM])
		do
			default_create
		end

	default_create
			-- <Precursor>
		do
			create poem_list
			create detail_view

			Precursor

			initialize

		end

	initialize
		do
			--	Horizontal_view ::= *Current or Current.widget
			--		Tree_list_of_poems
			--		Poem_detail_view
			widget.extend (poem_list)
			widget.extend (detail_view.widget)

		end

end
