class Administrator < ActiveRecord::Base
 has_one :login, :as => :owner

 accepts_nested_attributes_for :login, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

end
