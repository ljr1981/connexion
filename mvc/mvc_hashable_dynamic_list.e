deferred class
	MVC_HASHABLE_DYNAMIC_LIST [BT -> HASHABLE, V -> EV_DYNAMIC_LIST [EV_CONTAINABLE] create default_create end]

inherit
	MVC_HASHABLE_IDENTIFIABLE [BT, V]

feature {NONE} -- Initialization

	make_with_models (a_models: ARRAY [BT])
		do
			create models.make_from_array (a_models)
			default_create
		end

feature -- Access

	models: ARRAYED_LIST [BT]
		attribute
			create Result.make (10)
		end

feature -- Ops

	on_item_select
			-- What happens when a list item is selected?
		deferred
		end

end
