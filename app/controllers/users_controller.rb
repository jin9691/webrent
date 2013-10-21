class UsersController < ApplicationController
	before_filter :correct_user, except: [:register,:forgot_password,:reset_password,:update_password,:signup,:signup_access]
	before_filter :correct_admin, except: [:register,:forgot_password,:reset_password,:update_password,:signup,:signup_access]
	before_filter :correct_signup, only: [:signup]


	def new
		@user = User.new
	end

	def edit
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "Thêm tài khoản <b>#{@user.email}</b> thành công.".html_safe
			redirect_to users_path
		else
			render 'new'
		end
	end

	def update_permission
		users_id = params[:users_id].split(" ")
		users_id.each do |user_id|
			@user = User.find(user_id)
			@user.update_attribute("admin",params[:admin])
		end
	end

	def update_status
		users_id = params[:users_id].split(" ")
		users_id.each do |user_id|
			@user = User.find(user_id)
			@user.update_attribute("active",params[:status])
		end
	end

	def fill_permission
		if params[:a] == "true"
			admin = true
		else
			admin = false
		end
		@users = User.where(admin: admin,smod: false).paginate(:page => params[:page], :per_page => 10)
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Sửa tài khoản <b>#{@user.email}</b> thành công.".html_safe
			redirect_to users_path
		else
			render 'edit'
		end
	end

	def destroy
		messeage = "Đã xóa thành công các tài khoản: <br>"
		users_id = params[:users_id].split(" ")
		users_id.each do |user_id|
			@user = User.find(user_id)
			@user.destroy
			messeage += " - <b>#{@user.email}</b> <br>"
		end
		flash[:success] = messeage.html_safe
	end

	def index
		all_users = User.all.order("id desc")
		users = []
		all_users.each do |user|
			if current_user.smod
				if !user.smod
					users << user
				end
			else
				if !user.admin
					users << user
				end
			end
		end
		@count = users.count
		@users = users.paginate(:page => params[:page], :per_page => 10)
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
		if @user.nil? || @user.reset || @user.send_reset_at < 1.days.ago
			flash[:danger] = "Lấy lại mật khẩu đã hết hiệu lực. Hãy thử lại."
			redirect_to signin_path
		end
	end

	def update_password
		@user = User.find(params[:id])
		@user.update_attribute(:reset,true)
		@user.set_sid
		if @user.update_attributes(user_params)
			flash[:success] = "Đổi mật khẩu thành công. Bạn có thể đăng nhập vào website ngay bây giờ."
			redirect_to signin_path
		else
			render 'reset_password'
		end
	end

	def signup
		@user = User.new
	end

	def signup_access
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "Bạn đã đăng ký tài khoản Webrent thành công. Hãy kiểm tra email và kích hoạt tài khoản ngay bây giờ."
			Mailer.registration_confirmation(@user).deliver
			redirect_to signin_path
		else
			render 'signup'
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password,:password_confirmation,:active,:admin)
	end

	def correct_user
    	redirect_to(root_path) if current_user.nil?
	end

	def correct_signup
    	redirect_to edit_user_path(current_user) if !current_user.nil?
	end

	def correct_admin
		redirect_to(root_path) unless current_user.admin
	end

end
