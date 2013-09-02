class Mailer < ActionMailer::Base
	default :from => "no-reply@webrent.com"

	def registration_confirmation(user)
		@user = user
		mail(:to => "#{@user.name} <#{@user.email}>", :subject => "Đăng ký thành công")
	end

	def forgot_password(user)
		@user = user
		mail(:to => "#{@user.name} <#{@user.email}>", :subject => "Lấy lại mật khẩu")
	end

end
