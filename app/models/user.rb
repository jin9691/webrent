class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_create :set_sid
	has_many :website

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence:   true,
	format:     { with: VALID_EMAIL_REGEX },
	uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, :if => :validate_password?
	validates :password_confirmation, presence: true, :if => :validate_password?
	
	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def to_secure_param
		self.sid
	end

	def set_sid
		begin
			secure = SecureRandom.urlsafe_base64
		end while !User.find_by_sid(secure).nil?
		if self.new_record?
			self.sid = secure
		else
			self.update_column("sid", secure)
		end
	end

	def validate_password?
		password.present? || password_confirmation.present?
	end

	private

	def create_remember_token
		self.remember_token = User.encrypt(User.new_remember_token)
	end
end
