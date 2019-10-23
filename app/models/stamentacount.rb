class Stamentacount < ActiveRecord::Base

		has_many :stamentacount_details, :dependent => :destroy
end

