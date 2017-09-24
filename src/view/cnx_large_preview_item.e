note
	description: "[
		Medium Preivew item
		]"

class
	CNX_LARGE_PREVIEW_ITEM

inherit
	CNX_PREVIEW_ITEM

create
	default_create,
	make_with_preview_target

feature {NONE} -- Implementation

	preview_size: TUPLE [width, height: INTEGER]
		do
			Result := [constants.default_preview_size_width, constants.default_preview_size_height]
			widget.set_minimum_size (constants.default_preview_size_width, constants.default_preview_size_height)
		end

feature -- Constants

	constants: CNX_CONSTANTS once create Result end

end
