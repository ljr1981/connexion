note
	description: "[
		MVC facility for an EV_RICH_TEXT
		]"

class
	MVC_RICH_TEXT

inherit
	MVC_HASHABLE_PRIMITIVE [STRING_32, EV_RICH_TEXT]

create
	make_with_model,
	default_create

feature {NONE} -- Initialization

	initialize
			-- <Precursor>
		do
			view.change_actions.extend (agent view_to_model)
			view.set_text (attached_model)
		end

feature -- Ops

	remove_model
		do
			model := Void
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
			view.set_text (attached_model)
		end

	view_to_model
			-- `view_to_model' controller routine.
		do
			if view.text.is_empty then
				attached_model.wipe_out
			else
				attached_model.set (view.text, 1, view.text.count)
			end
		end

end
