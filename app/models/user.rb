class User < ApplicationRecord
  # digest(文字列のハッシュ化)の保存に必要
  has_secure_password
end
