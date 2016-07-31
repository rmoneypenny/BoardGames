class SevenWondersController < ApplicationController
  
  def new
  end

  def create
	@seven_wonder = SevenWonder.new(seven_wonder_params)

	@seven_wonder.save
	redirect_to @seven_wonder
  end

  def show
  	@seven_wonder = SevenWonder.find(params[:id])
  end

  private
  	def seven_wonder_params
  		params.require(:seven_wonder).permit(:gamenumber, :name, :boardname, :score, :win, :date)
  	end

end
