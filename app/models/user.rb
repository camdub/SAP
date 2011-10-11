class User < ActiveRecord::Base
  
  has_secure_password
  
  has_many :events
  has_and_belongs_to_many :roles
  
  def has_role role
    self.roles.include? Role.find_by_name(role)
  end
  
end
