class User < ActiveRecord::Base
  def base_accessible_method
    "This is a method accessible from the base class"
  end
end