note
	description: "[
		MVC facility for an EV_CHECK_BUTTON
		]"

class
	MVC_CHECK_BUTTON

inherit
	MVC_HASHABLE_PRIMITIVE [BOOLEAN, EV_CHECK_BUTTON]

create
	make_with_model,
	default_create

feature {NONE} -- Initialization

	initialize
			-- <Precursor>
		do
			view.select_actions.extend (agent view_to_model)
			if not attached_model = view.is_selected then
				view.toggle
			end
		end

feature -- Ops

	remove_model
		do
--			model := Void
			model_to_view_agent := Void
			view_to_model_agent := Void
		end

feature -- Setters: Model

	set_model (a_model: like attached_model)
		do
			model := a_model
		ensure
			set: model ~ a_model
		end

feature -- MVC: Routines

	model_to_view
			-- `model_to_view' controller routine.
		do
			if not attached_model = view.is_selected then
				view.toggle
			end
		end

	view_to_model
			-- `view_to_model' controller routine.
		do
			model.set_item (view.is_selected)
		end

end
