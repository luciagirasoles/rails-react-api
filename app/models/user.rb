# /app/models/user.rb
class User < ApplicationRecord
  has_secure_password
  has_secure_token

  def invalidate_token
    update(token: nil)
  end

  def self.valid_login?(email, password)
    user = find_by(email: email)
    user if user&.authenticate(password)
  end
end
