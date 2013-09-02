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
end
