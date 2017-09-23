note
	description: "[
		Root application class the Connexion Presentation App.
		]"

class
	CNX_APPLICATION

create
	make

feature {NONE} -- Initialization

	make
			-- `make' for Current.
		do
			create application
			create main_window.make_with_title ("Connexion")

			main_window.set_size (800, 600)

			main_window.close_request_actions.extend (agent application.destroy)

			application.post_launch_actions.extend (agent main_window.show)

			application.launch
		end

feature {NONE} -- Initialization

	application: EV_APPLICATION

	main_window: CNX_MAIN_WINDOW

end
