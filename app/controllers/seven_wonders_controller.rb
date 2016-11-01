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
    @winper = @seven_wonder.winper(@seven_wonder.getnames("all"),true).sort_by{|x,y|y}.reverse
  end

  def createPlayer
    @newPlayer = Player.create(name: params[:name])
    redirect_to user_seven_wonders_path
  end

  def user
    @seven_wonder = SevenWonder.new()
    @all = params[:all]
  end

  def boardList
    @seven_wonder = SevenWonder.new()
    @player_names = Player.new()  
    @names = params[:names]
    @all = params[:all]

  end

  def import
    @boardname = Swboardname.new
    @seven_wonder = SevenWonder.new
    @bnameFile = params[:bnfile]
    @swFile = params[:swfile]
    if @bnameFile
      @boardname.importCSV(@bnameFile)   
      redirect_to boardList_seven_wonders_path
    elsif @swFile
      @seven_wonder.importCSV(@swFile)   
      redirect_to players_seven_wonders_path
    end
  end

  def export
    @seven_wonder = SevenWonder.select(:gamenumber, :name, :boardname, :score, :win, :date)
    respond_to do |format|
      format.html {redirect_to players_seven_wonders_path}
      format.csv  {send_data @seven_wonder.to_csv}
    end
  end

  private
  	def seven_wonder_params
  		params.require(:seven_wonder).permit(:gamenumber, :name, :boardname, :score, :win, :date)
  	end



end
