class Player < ApplicationRecord
	def getnames
		Player.pluck("DISTINCT name")
	end
end
