class Ticket < ApplicationRecord
  validates_presence_of :name, :price
  belongs_to :event

  # 报名信息
  has_many :registrations
end
