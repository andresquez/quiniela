class PlayersController < ApplicationController
  include PlayersHelper

  before_action :set_player, only: %i[ show edit update destroy ]
  
  # GET /players or /players.json
  def index
    @players = Player.all
  end
  
  # GET /players/1 or /players/1.json
  def show
    Leaderboard.update_leaderboard
  end
  
  # GET /players/new
  def new
    @player = Player.new
    session[:saved_location] = request.referer

  end
  
  # GET /players/1/edit
  def edit
  end
  
  # POST /players or /players.json
  def create
    @player = Player.new(player_params)
    @player.role_id = 1
    @player.build_leaderboard(points: 0)

    

    if @player.save
      PlayerMailer.with(player: @player).welcome_player_email.deliver_now
      redirect_to login_players_url(@player), notice: "Player was successfully created."
    else
      redirect_to sign_up_players_path , alert: "Username already exists."
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
    session[:player_id ] = nil
    
    respond_to do |format|
      format.html { redirect_to home_path}
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
    # flash.discard(:notice)
  end
  
  # login method for players
  def login
    flash.discard(:notice)
    flash.discard(:alert)
    if request.post?
      # check if player exists
      @player = Player.find_by(username: params[:username])
      if @player && @player.password == params[:password]
        # set session variable
        session[:player_id] = @player.id
        # redirect to home/profile page with notice
        redirect_to home_path, notice: "Login successful."
      else
        # redirect back to login page with alert
        redirect_to login_players_path, alert: "Incorrect username or password."
      end
    end
    flash.discard(:notice)
  end
  

  # logout method for players
  def logout
    # reset session variable
    session[:player_id] = nil
    # redirect to login page
    redirect_to root_path
  end
  
  # home method for players
  def home 
    if session[:player_id]
      @player = Player.find(session[:player_id])
      @predictions = @player.predictions
    else
      redirect_to root_path
    end


  def root 
  end 


  end
  
  # show profile method for players
  def profile 
  end
  
  
  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_player
    @player = Player.find(params[:id])
  end

  # set current player
  def set_current_player
    if session[:player_id]
      @current_player = Player.find_by(id: session[:player_id])
    end
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
