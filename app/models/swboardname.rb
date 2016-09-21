class Swboardname < ApplicationRecord

	require 'csv'

	def importCSV(file)

		CSV.foreach(file.path) do |line|
			Swboardname.create(name: line[0])
		end
	end

end
