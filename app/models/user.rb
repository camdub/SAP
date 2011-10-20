class User < ActiveRecord::Base
  
  has_secure_password
  
  has_many :events
  has_and_belongs_to_many :roles
  
  def has_role role
    self.roles.include? Role.find_by_name(role)
  end
  
  def user_data
    {
      :firstname => self.firstname, 
      :lastname => self.lastname, 
      :netid => self.netid,
      :can_read_all_events => true,
      :can_read_own_events => true,
      :can_write_events => true,
      :can_book_own_appointments => true,
      :can_book_all_appointments => true
    }
  end
  
end
