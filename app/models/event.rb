class Event < ApplicationRecord

 validates_presence_of :name, :friendly_id

 validates_uniqueness_of :friendly_id
 validates_format_of :friendly_id, :with => /\A[a-z0-9\_]+\z/

# 在新增的时候运行方法，生成friendly_id
 before_validation :generate_friendly_id, :on => :create

 def to_param
  #  "#{self.id}-#{self.name}"
  self.friendly_id
 end

 protected

#生成friendly_id
 def generate_friendly_id
   self.friendly_id ||= SecureRandom.uuid
 end

end
