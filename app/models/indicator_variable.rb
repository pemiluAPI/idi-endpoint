class IndicatorVariable < ActiveRecord::Base
	belongs_to :time_serie
	belongs_to :indicator
end
