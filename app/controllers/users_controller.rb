class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def register
		@user = User.find_by_sid(params[:id])
		if @user.nil?
			flash[:success] = "Tài khoản của bạn đã được kích hoạt. Bạn có thể login vào website của chúng tôi ngay bây giờ."
			redirect_to signin_path
		else
			if @user.update_attribute(:active, true)
				flash[:success] = "Tài khoản của bạn đã được kích hoạt. Bạn có thể login vào website của chúng tôi ngay bây giờ."
				@user.set_sid
				redirect_to signin_path
			end
		end
	end

	def forgot_password
		@user = User.find_by_email(params[:email])
		unless @user.nil?
			@user.update_attribute(:reset,false)
			@user.update_attribute(:send_reset_at,Time.zone.now)
			Mailer.forgot_password(@user).deliver
		end
	end

	def reset_password
		@user = User.find_by_sid(params[:id])
		if @user.reset || @user.send_reset_at < 1.days.ago
			flash[:error] = "Password reset has expired."
			redirect_to signin_path
		end
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "Bạn đã đăng ký tài khoản Webrent thành công. Hãy kiểm tra email và kích hoạt tài khoản ngay bây giờ."
			Mailer.registration_confirmation(@user).deliver
			redirect_to signin_path
		else
			render 'new'
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password,:password_confirmation)
	end

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user)
	end
end