class SessionsController < ApplicationController
	skip_before_filter :signed_in_user
	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password]) && user.parent_id.nil? && user.active
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
end
