class BoardgameController < ApplicationController

	def index
		@seven_wonder = SevenWonder.new()
		@game = params[:game]
	end

end
