note
	description: "[
		List of items with label
		]"

class
	CNX_ITEM_LIST

inherit
	CNX_VERTICAL_BOX_WIDGET

create
	make

feature {NONE} -- GUI Bits

	label: EV_LABEL
	list: EV_LIST

feature {NONE} -- Initialization

	make (a_label_text: STRING)
			--
		do
				-- Creations
			create widget
			create label.make_with_text (a_label_text)
			create list

				-- Extensions
			widget.extend (label)
			widget.extend (list)

				-- Disables
			widget.disable_item_expand (label)

				-- Settings
			label.align_text_left

			default_create
		end

feature {NONE} -- Implementation

	minimum_width: INTEGER = 150

end
