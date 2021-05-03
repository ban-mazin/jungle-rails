class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, :uniqueness => {:case_sensitive => false}
  validates :password, presence: true,length: { in: 6..20 }
  validates :password_confirmation, presence: true
  validates :name, presence: true
  before_save :downcase_email 
  def downcase_email
    self.email.downcase!
  end

  def self.authenticate_with_credentials (email, password)
    e = email.squish.downcase
    user = User.find_by_email(e)
    if user && user.authenticate(password)
      @user = user
    else
      nil
    end
  end

end