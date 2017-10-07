class Registration < ApplicationRecord

  STATUS = ["pending", "confirmed"]
  validates_inclusion_of :status, :in => STATUS
  validates_presence_of :status, :ticket_id

# 在多步骤中特定步骤中进行验证
  attr_accessor :current_step
  validates_presence_of :name, :email, :cellphone, :if => :should_validate_basic_data?
  validates_presence_of :name, :email, :cellphone, :bio, :if => :should_validate_all_data?

  # 添加event状态的校验，自定义验证资料，on是指在create时候进行验证
  validate :check_event_status, :on => :create

  belongs_to :event
  belongs_to :ticket
  belongs_to :users, :optional => true

  before_validation :generate_uuid, :on => :create

  def to_param
    self.uuid
  end

  protected

# 在第二步骤时候验证
  def should_validate_basic_data?
    current_step == 2
  end

# 在第三步骤或者状态是confirmed时候验证
  def should_validate_all_data?
    current_step == 3 || status == "confirmed"
  end

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

  # 验证event状态
  def check_event_status
      if self.event.status == "draft"
        errors.add(:base, "活动尚未开放报名")
      end
  end

end
