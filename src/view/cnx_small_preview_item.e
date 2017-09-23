note
	description: "[
		Small Preivew item
		]"

class
	CNX_SMALL_PREVIEW_ITEM

inherit
	CNX_PREVIEW_ITEM

create
	default_create,
	make_with_preview_target

feature {NONE} -- Implementation

	preview_size: TUPLE [width, height: INTEGER]
		do
			Result := [160, 90]
		end

end
