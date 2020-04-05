class User < ApplicationRecord
  # digest(文字列のハッシュ化)の保存に必要
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :tasks, dependent: :destroy
end
