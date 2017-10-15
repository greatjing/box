class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

# 所有角色
  ROLES = ["admin", "editor"]

# user与group关系
  has_many :memberships
  has_many :groups, :through => :memberships

# user与profile关系
  has_one :profile
  # 在更新user时候，接受更新profile
  accepts_nested_attributes_for :profile

  # 报名信息
  has_many :registrations

  # 判断用户是否是admin用户
  def is_admin?
    self.role == "admin"
  end

  # 判断用户是否是editor用户
  def is_editor?
    ["admin", "editor"].include?(self.role)
  end

  def display_name
    self.email.split("@").first
  end

end
