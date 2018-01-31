class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_save   :downcase_email
  before_create :create_activation_digest

  before_save {self.email = email.downcase} #不可写成 email = email.downcase。 左侧的self 不能丢.
  # 可以写成before_save { email.downcase! }

  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255}
  validates :email, format: {with: /\A[\w+-.]+@[a-z\d.-]+\.[a-z]+\z/i } #匹配格式
  validates :email, uniqueness: {case_sensitive: false} #唯一（不区分大小写）
  # validates :email, uniqueness: {case_sensitive: true} #唯一（区分大小写） 等价于   validates :email, uniqueness: true

  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  #返回指定字符串的哈希摘要
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # 返回一个随机令牌
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 为了持久保存会话，在数据库中记住用户
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 如果指定的令牌和摘要匹配，返回 true
  # def authenticated?(remember_token)
  #   return false if remember_digest.nil?
  #   BCrypt::Password.new(remember_digest).is_password?(remember_token)
  # end
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  #忘记用户
  def forget
    update_attribute(:remember_digest, nil)
  end

  # 激活账户
  def activate
    #两条语句需要执行两个数据库事务更改成一条语句--只执行一次数据库事务
    # update_attribute(:activated,    true)
    # update_attribute(:activated_at, Time.zone.now)

    update_columns(activated: true, activated_at: Time.now)

  end

  # 发送激活邮件
  def  send_activation_email
    UserMailer.account_activation(self).deliver
  end


  private

  # 把电子邮件地址转换成小写
  def downcase_email
    self.email = email.downcase
  end

  # 创建并赋值激活令牌和摘要
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

end
