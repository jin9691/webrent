module UsersHelper
	def status_label(status)
		if status == true
			return "<span class='label label-primary'>Đã kích hoạt</span>"
		else
			return "<span class='label label-webrent'>Chưa kích hoạt</span>"
		end
	end

	def admin_label(admin,smod)
		if admin == true
			return "<span class='label label-success'>Quản trị viên</span>" if smod == false
			return "<span class='label label-danger'>Siêu quản trị</span>" if smod == true
		else
			return "<span class='label label-warning'>Người dùng</span>"
		end
	end

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
