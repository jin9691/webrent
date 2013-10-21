class SessionsController < ApplicationController
	before_filter :correct_signin, only: [:create,:new]
	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password]) && user.active
			sign_in user
			redirect_to welcome_path
		else
			flash.now[:danger] = 'Email hoặc mật khẩu không đúng, mời thử lại!'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end

	def correct_signin
    	if !current_user.nil?
    		sign_out
			redirect_to root_url
    	end
	end
end
