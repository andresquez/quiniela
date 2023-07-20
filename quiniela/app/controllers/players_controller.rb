class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show edit update destroy ]
  
  # GET /players or /players.json
  def index
    @players = Player.all
  end
  
  # GET /players/1 or /players/1.json
  def show
  end
  
  # GET /players/new
  def new
    @player = Player.new
  end
  
  # GET /players/1/edit
  def edit
  end
  
  # POST /players or /players.json
  def create
    @player = Player.new(player_params)
    @player.role_id = 1
    
    respond_to do |format|
      if @player.save
        PlayerMailer.with(player: @player).welcome_player_email.deliver_now
        format.html { redirect_to login_players_url(@player), notice: "Player was successfully created." }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /players/1 or /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to player_url(@player), notice: "Player was successfully updated." }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /players/1 or /players/1.json
  def destroy
    @player.destroy
    
    respond_to do |format|
      format.html { redirect_to players_url, notice: "Player was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  
  # sign up method for players
  def sign_up 
    @player = Player.new
    respond_to do |format|
      format.html
      format.xml { render xml: @matches}
      format.json { render json: @matches}
    end
  end
  
  # login method for players
  def login
    puts "entre al login" 
    # check if player exists
    @player = Player.find_by(username: params[:username])
    if @player
      # check if password is correct
      if @player.password == params[:password]
        # set session variable
        puts "entre al if"
        session[:player_id] = @player.id
        puts "Player id: #{session[:player_id]}"
        # redirect to home/profile page
        redirect_to home_path
      else
        # flash[:error] = "Incorrect password"
      end
    else
      # flash[:error] = "Player does not exist"
    end
  end

  # logout method for players
  def logout
    # reset session variable
    session[:player_id] = nil
    # redirect to login page
    redirect_to login_players_path
  end
  
  # home method for players
  def home 
    @player = Player.find(session[:player_id])
    @predictions = @player.predictions
  end
  
  # show profile method for players
  def profile 
  end
  
  
  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_player
    @player = Player.find(params[:id])
  end
  
  # Only allow a list of trusted parameters through.
  def player_params
    params.require(:player).permit(:id,
      :username,
      :password,
      :role_id
    )
  end
end
