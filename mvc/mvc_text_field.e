note
	description: "[
		MVC facility for an EV_TEXT_FIELD
		]"
	design: "[
		MVC or rather -- CVM or CVMV

		]"

class
	MVC_TEXT_FIELD

inherit
	ANY
		redefine
			default_create
		end

create
	make_with_model,
	default_create

feature {NONE} -- Initialization

	make_with_model (a_model: like attached_model)
			-- `make_with_model' using `a_model'
		do
			default_create
			model := a_model
			view.change_actions.extend (agent view_to_model)
			view.set_text (attached_model)
		end

	default_create
			-- <Precursor>
		do
			create view
		end

feature -- Acces

	view: EV_TEXT_FIELD
			-- The `view' of the MVC model.

	model: detachable STRING_32
			-- The `model' of the MVC model.

	attached_model: attached like model
			-- Attached version of `model'
			-- We think we will always have a view, but we might not have a model.
		do
			check attached model as al_model then Result := al_model end
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

feature -- Setters: MVC Controller Agents

	set_model_to_view_agent (a_agent: like model_to_view_agent)
			-- Set `model_to_view_agent'
		do
			model_to_view_agent := a_agent
		end

	set_view_to_model_agent (a_agent: like view_to_model_agent)
			-- Set `view_to_model_agent'
		do
			view_to_model_agent := a_agent
		end

feature -- MVC: Routines

	model_to_view
		require
			has_model: attached model
		do
			view.set_text (attached_model)
		end

	view_to_model
		require
			has_model: attached model
		do
			if view.text.is_empty then
				attached_model.wipe_out
			else
				attached_model.set (view.text, 1, view.text.count)
			end
		end

feature -- MVC: Controller Agents

	model_to_view_agent: detachable PROCEDURE [STRING_32]

	attached_model_to_view_agent: PROCEDURE [STRING_32]
		do
			check attached attached_model_to_view_agent as al_agent then Result := al_agent end
		end

	view_to_model_agent: detachable PROCEDURE [STRING_32]

	attached_view_to_model_agent: PROCEDURE [STRING_32]
		do
			check attached attached_view_to_model_agent as al_agent then Result := al_agent end
		end

end
