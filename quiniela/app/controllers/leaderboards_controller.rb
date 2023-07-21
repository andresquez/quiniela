class LeaderboardsController < ApplicationController
  before_action :set_leaderboard, only: %i[ show edit update destroy ]

  # GET /leaderboards or /leaderboards.json
  def index
    UpdatePointsJob.perform_now()
    @leaderboards = Leaderboard.all
  end

  # GET /leaderboards/1 or /leaderboards/1.json
  def show
  end

  # GET /leaderboards/new
  def new
    @leaderboard = Leaderboard.new
    session[:saved_location] = request.referer

  end

  # GET /leaderboards/1/edit
  def edit
  end

  # POST /leaderboards or /leaderboards.json
  def create
    @leaderboard = Leaderboard.new(leaderboard_params)

    respond_to do |format|
      if @leaderboard.save
        format.html { redirect_to leaderboard_url(@leaderboard), notice: "Leaderboard was successfully created." }
        format.json { render :show, status: :created, location: @leaderboard }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @leaderboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leaderboards/1 or /leaderboards/1.json
  def update
    respond_to do |format|
      if @leaderboard.update(leaderboard_params)
        format.html { redirect_to leaderboard_url(@leaderboard), notice: "Leaderboard was successfully updated." }
        format.json { render :show, status: :ok, location: @leaderboard }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @leaderboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leaderboards/1 or /leaderboards/1.json
  def destroy
    @leaderboard.destroy

    respond_to do |format|
      format.html { redirect_to leaderboards_url, notice: "Leaderboard was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leaderboard
      @leaderboard = Leaderboard.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def leaderboard_params
      params.require(:leaderboard).permit(
        :id,
        :user_id,
        :points
      )
    end
end
