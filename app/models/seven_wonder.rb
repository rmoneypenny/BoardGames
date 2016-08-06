class SevenWonder < ApplicationRecord

	def getnames
		SevenWonder.pluck("DISTINCT name")
	end

	def selectednames(names=[""])
		names
	end

end
