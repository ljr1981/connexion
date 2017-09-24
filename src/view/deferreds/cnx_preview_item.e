note
	description: "[
		Consists of left-center-right with center-preview item
		]"

deferred class
	CNX_PREVIEW_ITEM

inherit
	CNX_HORIZONTAL_BOX_WIDGET
		redefine
			default_create
		end

feature {CNX_PREVIEW_ITEM} -- GUI Bits

	preview: CNX_PREVIEW_WIDGET

feature {NONE} -- GUI Bits

	left_cell,
	right_cell: EV_CELL

	left_vbox: EV_VERTICAL_BOX

	right_vbox: EV_VERTICAL_BOX
	right_hbox: EV_HORIZONTAL_BOX
	right_button_left_cell,
	right_button_right_cell: EV_CELL

	move_to_preview_button: EV_BUTTON

	preview_widget_cell: EV_CELL
	preview_vbox: EV_VERTICAL_BOX
	preview_hbox,
	preview_control_hbox: EV_HORIZONTAL_BOX

feature {NONE} -- Initialization

	make_with_preview_target (a_target: CNX_PREVIEW_ITEM)
			--
		do
			target_for_move_to := a_target
			default_create
		end

	default_create
			-- <Precursor>
		do
			create widget

			Precursor

			create left_cell
			create left_vbox

			create right_cell
			create move_to_preview_button.make_with_text_and_action (">>", agent on_move)
			create right_vbox
			create right_hbox
			create right_button_left_cell
			create right_button_right_cell

			create preview
			create preview_widget_cell
			create preview_vbox
			create preview_hbox
			create preview_control_hbox

				-- Extensions
			widget.extend (left_cell)
				left_cell.extend (left_vbox)
			widget.extend (preview_vbox)
				preview_vbox.extend (preview_widget_cell)
					preview_widget_cell.extend (preview.widget)
				preview_vbox.extend (preview_hbox)
					preview_hbox.extend (create {EV_CELL})
					preview_hbox.extend (preview_control_hbox)
					preview_hbox.extend (create {EV_CELL})
			widget.extend (right_cell)
				right_cell.extend (right_hbox)
--				if attached target_for_move_to then
--					right_hbox.extend (right_button_left_cell)
--					right_hbox.extend (right_vbox)
--					right_hbox.extend (right_button_right_cell)
--					right_vbox.extend (create {EV_CELL})
--					right_vbox.extend (move_to_preview_button)
--					right_vbox.extend (create {EV_CELL})
--				end

				-- Disables
			widget.disable_item_expand (left_cell)
			widget.disable_item_expand (right_cell)
			preview_vbox.disable_item_expand (preview_hbox)
			preview_hbox.disable_item_expand (preview_control_hbox)

				-- Settings
			preview_control_hbox.set_border_width (3)
			preview_control_hbox.set_padding (3)
			preview.widget.set_size (preview_size.width, preview_size.height)
			preview.wipe_out
			if attached target_for_move_to then
				preview.widget.pointer_double_press_actions.extend (agent on_preview_double_click)
			end
		end

feature -- Events

	on_preview_double_click (a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32)
		do
			on_move
		end

	on_move
			-- Headed to the next preview item for preview
		do
			if attached target_for_move_to then
				attached_target_for_move_to.preview.wipe_out
				attached_target_for_move_to.preview.set_actions_twin (preview.actions)
				attached_target_for_move_to.preview.refresh
				attached_target_for_move_to.on_move
			end
			if attached target_for_display then
				attached_target_for_display.display.set_actions_twin (preview.actions)
				attached_target_for_display.display.refresh
			end
		end

	on_blank_click
			-- What happens when "blank button" is clicked
		do
			preview.wipe_out
		end

	on_blank_and_move
		do
			on_blank_click
			on_move
		end

	on_set_stanza (a_stanza: CNX_STANZA; a_poem: CNX_POEM)
		do
			preview.actions.extend (agent preview.on_draw_text (a_stanza.text, ?))
			preview.actions.extend (agent preview.on_draw_citation (a_poem.title, ?))
			preview.refresh
		end

feature -- Access

	target_for_move_to: detachable CNX_PREVIEW_ITEM
			-- Where do we move to `on_move'?

	attached_target_for_move_to: attached like target_for_move_to
		do
			check attached target_for_move_to as al_target then Result := al_target end
		end

	target_for_display: detachable CNX_DISPLAY_WINDOW
			-- Where is our main `target_for_display'?

	attached_target_for_display: attached like target_for_display
		do
			check attached target_for_display as al_target then Result := al_target end
		end

feature -- Setters

	set_display_target (a_target: attached like target_for_display)
		do
			target_for_display := a_target
		end

feature -- Ops

	enable_blanking
		local
			l_button: EV_BUTTON
		do
			create l_button.make_with_text_and_action ("Blank", agent on_blank_and_move)
			preview_control_hbox.extend (l_button)
		end

feature {NONE} -- Imlementation

	preview_size: TUPLE [width, height: INTEGER]
		deferred
		end

invariant
	valid_target: attached target_for_move_to implies right_cell.has (right_hbox)

end
