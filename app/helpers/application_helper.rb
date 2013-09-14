module ApplicationHelper
	def check_error(controler,action)
		if controler == "users" && action == "show"
			return true
		end
		if controler == "sessions" && action == "new"
			return true
		end
		if controler == "users" && action == "update_password"
			return true
		end
		return false
	end

	def check_background(controler,action)
		if controler == "static_pages" && action == "home"
			return "homepage"
		end
		if controler == "static_pages" && action == "welcome"
			return "main-webrent"
		end
		if controler == "sessions" && action == "new"
			return "homepage"
		end
		if controler == "sessions" && action == "create"
			return "homepage"
		end
		if controler == "users" && action == "new"
			return "homepage"
		end
		if controler == "users" && action == "create"
			return "homepage"
		end
	end

	def check_page(controler,action)
		if controler == "static_pages" && action == "welcome"
			return "welcome"
		end
		if controler == "sessions" && action == "new"
			return "signin"
		end
		if controler == "users" && action == "new"
			return "signup"
		end
		
	end
end
