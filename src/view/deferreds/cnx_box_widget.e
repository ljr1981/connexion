note
	description: "Basic CNX Widget"

deferred class
	CNX_BOX_WIDGET [G -> EV_BOX]

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Implementation

	default_create
			--
		do
			widget.set_border_width (3)
			widget.set_padding (3)
		end

feature -- Access

	widget: G

end
