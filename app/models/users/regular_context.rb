require 'active_record_view'

class Users::RegularContext < User
  include ActiveRecordView
  @column_inclusions = ["first_name","last_name"]

  def context_specific_method
    "This method is available from the regular user specific context"
  end
end