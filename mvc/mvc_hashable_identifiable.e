deferred class
	MVC_HASHABLE_IDENTIFIABLE [M -> HASHABLE, V -> EV_IDENTIFIABLE create default_create end]

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	make_with_model (a_model: like attached_model)
			-- `make_with_model' using `a_model'
		do
			default_create
			model := a_model
			initialize
		end

	initialize
		deferred
		end

	default_create
			-- <Precursor>
		do
			create view
		end

feature -- Acces

	view: V
			-- The `view' of the MVC model.

	base_type: detachable M

	attached_base_type: M
		do
			check attached base_type as al_base_type then Result := al_base_type end
		end

	model: detachable M
			-- The `model' of the MVC model.

	attached_model: attached M
			-- Attached version of `model'
			-- We think we will always have a view, but we might not have a model.
		do
			check attached model as al_model then Result := al_model end
		end

feature -- MVC: Routines

	model_to_view
			-- `model_to_view' controller routine.
		require else
			has_model: attached model
		deferred
		end

	view_to_model
			-- `view_to_model' controller routine.
		require else
			has_model: attached model
		deferred
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

feature -- MVC: Controller Agents

	model_to_view_agent: detachable PROCEDURE [M]
			-- `model_to_view_agent' with `a_value'.

	attached_model_to_view_agent: PROCEDURE [M]
		do
			check attached attached_model_to_view_agent as al_agent then Result := al_agent end
		end

	view_to_model_agent: detachable PROCEDURE
			-- `view_to_model_agent'.

	attached_view_to_model_agent: PROCEDURE [M]
		do
			check attached attached_view_to_model_agent as al_agent then Result := al_agent end
		end



end
