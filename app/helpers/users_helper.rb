module UsersHelper
	def gender_error(msg)
		if msg == "Name can't be blank"
			return "Họ và tên không được để trống"
		elsif msg == "Email can't be blank"
			return "Địa chỉ email không được để trống"
		elsif msg == "Email is invalid"
			return "Địa chỉ email không đúng định dạng"
		elsif msg == "Password can't be blank"
			return "Mật khẩu không được để trống"
		elsif msg == "Password is too short (minimum is 6 characters)"
			return "Mật khẩu quá ngắn (cần ít nhất 6 kí tự)"
		elsif msg == "Email has already been taken"
			return "Địa chỉ email đã được đăng ký, hãy thử email khác"
		else
			return "Nhập lại mật khẩu không khớp"
		end
	end
end
