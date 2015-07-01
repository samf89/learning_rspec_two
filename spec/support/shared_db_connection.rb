# see page 117
class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_conntection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end

ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
