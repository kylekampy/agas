class Administrator < ActiveRecord::Base
 has_one :login, :as => :owner
end
