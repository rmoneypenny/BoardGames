class SevenWondersController < ApplicationController


  def index
    @seven_wonder = SevenWonder.new()
  end

  def new
    @seven_wonder = SevenWonder.new()
    @name = cookies[:name].split("&")
    @n = @name.size
  end

  def create
	 @seven_wonder = SevenWonder.new(seven_wonder_params)

	 @seven_wonder.save
	 redirect_to @seven_wonder
  end

  def players
    @seven_wonder = SevenWonder.new()
    @player_names = Player.new()  
    @names = params[:names]
    @all = params[:all]
  end

  def show
  	@seven_wonder = SevenWonder.find(params[:id])
  end

  def review
    @seven_wonder = SevenWonder.new()
    @seven_wonder.submitGame(params[:name], params[:boardname], params[:score])

    #cookies[:selectedname] ||= {value: params[:name], expires: 1.hour.from_now}
    #cookies[:boardname] ||= {value: params[:boardname], expires: 1.hour.from_now}
    #cookies[:score] ||= {value: params[:score], expires: 1.hour.from_now}
  end

  def history
    @seven_wonder = SevenWonder.new()
  end

  def stats
    @seven_wonder = SevenWonder.new()
    @highestScore = SevenWonder.maximum('score')
    @name = SevenWonder.select(:name).where(score: @highestScore)
    @winper = @seven_wonder.winper()
  end

  def createPlayer
    @newPlayer = Player.create(name: params[:name])
    redirect_to user_seven_wonders_path
  end

  def user
    @seven_wonder = SevenWonder.new()
  end

  def boardList
    @seven_wonder = SevenWonder.new()
    @names = params[:names]
  end

  def import
    @boardname = Swboardname.new
    @boardname.importCSV(params[:file])   
    redirect_to boardList_seven_wonders_path
  end

  private
  	def seven_wonder_params
  		params.require(:seven_wonder).permit(:gamenumber, :name, :boardname, :score, :win, :date)
  	end



end
