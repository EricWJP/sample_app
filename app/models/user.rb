class User < ApplicationRecord

  before_save {self.email = email.downcase} #不可写成 email = email.downcase。 左侧的self 不能丢.
  # 可以写成before_save { email.downcase! }

  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255}
  validates :email, format: {with: /\A[\w+-.]+@[a-z\d.-]+\.[a-z]+\z/i } #匹配格式
  validates :email, uniqueness: {case_sensitive: false} #唯一（不区分大小写）
  # validates :email, uniqueness: {case_sensitive: true} #唯一（区分大小写） 等价于   validates :email, uniqueness: true

  has_secure_password
  validates :password, presence: true, length: {minimum: 6}

end
