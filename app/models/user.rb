class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


# user与group关系
  has_many :memberships
  has_many :groups, :through => :memberships

# user与profile关系
  has_one :profile
  # 在更新user时候，接受更新profile
  accepts_nested_attributes_for :profile

  # 报名信息
  has_many :registrations

  def display_name
    self.email.split("@").first
  end

end
