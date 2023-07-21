class PredictionsController < ApplicationController
  before_action :set_prediction, only: %i[ show edit update destroy ]

  # GET /predictions or /predictions.json
  def index
    @predictions = Prediction.where(player_id: params[:player_id])

    respond_to do |format|
      format.html
      format.xml { render xml: @predictions}
      format.json { render json: @predictions}
    end
  end

  # GET /predictions/1 or /predictions/1.json
  def show
  end

  # GET /predictions/new
  def new
    @prediction = Prediction.new
    @matches = Match.all
    session[:saved_location] = request.referer

  end

  # GET /predictions/1/edit
  def edit
    @matches = Match.all
    @prediction = Prediction.find(params[:id])
    session[:saved_location] = request.referer


  end

  # POST /predictions or /predictions.json
  def create    
    @prediction = Prediction.new(prediction_params)
    @prediction.player_id = session[:player_id]


    respond_to do |format|
      if @prediction.save
        format.html { redirect_to prediction_url(@prediction), notice: "Prediction was successfully created." }
        format.json { render :show, status: :created, location: @prediction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @prediction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /predictions/1 or /predictions/1.json
  def update
    respond_to do |format|
      if @prediction.update(prediction_params)
        format.html { redirect_to prediction_url(@prediction), notice: "Prediction was successfully updated." }
        format.json { render :show, status: :ok, location: @prediction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @prediction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /predictions/1 or /predictions/1.json
  def destroy
    @prediction.destroy

    respond_to do |format|
      format.html { redirect_to predictions_url, notice: "Prediction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prediction
      @prediction = Prediction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def prediction_params
      params.require(:prediction).permit(
        :match_id,
        :goals1,
        :goals2
      )
    end
end
