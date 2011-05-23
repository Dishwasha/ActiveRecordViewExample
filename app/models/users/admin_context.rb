require 'active_record_view'

class Users::AdminContext < User
  include ActiveRecordView
  @column_inclusions = ["first_name","last_name","ssn","phone"]

  def context_specific_method
    "This method is available from the admin user specific context"
  end

  def SSN 
    self.ssn
  end
end