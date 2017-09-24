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
			Result := [600, 450]
			widget.set_minimum_size (600, 450)
		end

end
