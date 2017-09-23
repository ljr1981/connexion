note
	description: "[
		Medium Preivew item
		]"

class
	CNX_MEDIUM_PREVIEW_ITEM

inherit
	CNX_PREVIEW_ITEM

create
	default_create,
	make_with_preview_target

feature {NONE} -- Implementation

	preview_size: TUPLE [width, height: INTEGER]
		do
			Result := [280, 164]
		end

end
