class Province < ActiveRecord::Base
	has_many :time_series
end
