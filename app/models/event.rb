class Event < ApplicationRecord

 validates_presence_of :name, :friendly_id

 validates_uniqueness_of :friendly_id
 validates_format_of :friendly_id, :with => /\A[a-z0-9\-]+\z/

# 在新增的时候运行方法，生成friendly_id
 before_validation :generate_friendly_id, :on => :create

 belongs_to :category, :optional => true

# 下面:inverse_of为了解决rails一个bug
 has_many :tickets, :dependent => :destroy, :inverse_of => :event
 accepts_nested_attributes_for :tickets, :allow_destroy => true, :reject_if => :all_blank

 # 报名信息
 has_many :registrations, :dependent => :destroy

 # 常用查找定义
 scope :only_public, -> { where( :status => "public" ) }
 scope :only_available, -> { where( :status => ["public", "private"] ) }

 # 挂载图片
 mount_uploader :logo, EventLogoUploader

 # 挂载多图片
 mount_uploaders :images, EventImageUploader
 serialize :images, JSON

 # 挂载多图片，每个图片都可以单独编辑
 has_many :attachments, :class_name => "EventAttachment", :dependent => :destroy
 accepts_nested_attributes_for :attachments, :allow_destroy => true, :reject_if => :all_blank

 def to_param
  #  "#{self.id}-#{self.name}"
  self.friendly_id
 end

 # event状态
 STATUS = ["draft", "public", "private"]
 validates_inclusion_of :status, :in => STATUS

 # 自定义排序
 include RankedModel
 ranks :row_order

 protected

#生成friendly_id
 def generate_friendly_id
   self.friendly_id ||= SecureRandom.uuid
 end

end
