class AdministratorsController < ApplicationController
	def index
		if !current_user.admin
			redirect_to welcome_path
		else
			
		end
	end
end
