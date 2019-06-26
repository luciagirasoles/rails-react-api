# /app/models/user.rb
class User < ApplicationRecord
  has_secure_password
end
