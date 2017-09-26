class
	MVC_TREE

inherit
	MVC_HASHABLE_DYNAMIC_LIST [STRING_32, EV_TREE]

create
	make_with_models,
	default_create

feature {NONE} -- Initialization

	initialize
			-- <Precursor>
		do
			view.select_actions.extend (agent on_item_select)
		end

feature -- Ops

	on_item_select
			-- What happens when a list item is selected?
		require else
			has_item: attached view.selected_item
		do
			if
				attached view.selected_item as al_selected_item and then
				attached {like model} al_selected_item.data as al_item
			then
				model := al_item
			end
		ensure then
			has_model: attached model as al_model implies
						attached view.selected_item as al_selected_item and then
						al_model ~ al_selected_item.data
		end

feature -- MVC: Routines

	model_to_view
			-- `model_to_view' controller routine.
		note
			do_nothing: "[
				Why `do_nothing'?
				
				A list like MVC_TREE has references to a list of models,
				but it is not the keeper of the model. There is a model
				which operates as the container for models in this list.
				]"
		do
			do_nothing -- Model references are here, but no models.
		end

	view_to_model
			-- `view_to_model' controller routine.
		note
			do_nothing: "[
				Why `do_nothing'?
				
				A list like MVC_TREE has references to a list of models,
				but it is not the keeper of the model. There is a model
				which operates as the container for models in this list.
				]"
		do
			do_nothing -- Model references are here, but no models.
		end

end
