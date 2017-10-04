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

  def display_name
    self.email.split("@").first
  end

end
