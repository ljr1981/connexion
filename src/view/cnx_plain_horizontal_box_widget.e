note
	description: "[
		A widgitized Horizontal Box widget thingy
		]"

class
	CNX_PLAIN_HORIZONTAL_BOX_WIDGET

inherit
	CNX_HORIZONTAL_BOX_WIDGET
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- <Precursor>
		do
			create widget
		end

feature {NONE} -- Implementation

	minimum_width: INTEGER = 50

end
