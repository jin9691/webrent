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

	def check_background()
		if request.fullpath.split("/")[1] == nil
			return "homepage"
		end
		if request.fullpath.split("/")[1]  == "welcome"
			return "main-webrent"
		end
		if request.fullpath.split("/")[1] == "sessions"
			return "homepage"
		end
		if request.fullpath.split("/")[1] == "signin"
			return "homepage"
		end
		if request.fullpath.split("/")[1] == "signup"
			return "homepage"
		end
		if request.fullpath.split("/")[1] == "users"
			return "homepage"
		end
		if request.fullpath.split("/")[1] == "signup_access"
			return "homepage"
		end
		if request.fullpath.split("/")[1] == "administrators"
			return "administrators"
		end
	end

	def check_page()
		return request.fullpath.split("/")[1],request.fullpath.split("/")[2]
	end

	def check_controller()
		return params[:controller]
	end
end
