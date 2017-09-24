note
	description: "[
		A widgitized Vertical Box widget thingy
		]"

class
	CNX_PLAIN_VERTICAL_BOX_WIDGET

inherit
	CNX_VERTICAL_BOX_WIDGET
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- <Precursor>
		do
			create widget
		end

end
