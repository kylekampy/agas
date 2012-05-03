class Bill < ActiveRecord::Base
  attr_accessible :unique_hash, :status, :price, :insurance_coverage, :date, :time
end
