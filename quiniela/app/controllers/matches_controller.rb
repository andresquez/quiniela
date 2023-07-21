class MatchesController < ApplicationController
    before_action :set_match, only: %i[ show edit update destroy ]
    
    # method to show all matches
    def all
        @matches = Match.all
    end

    # GET /matches or /matches.json
    def index
        @matches = Match.joins(:prediction).where(predictions: { player_id: params[:player_id] })

        respond_to do |format|
            format.html
            format.xml { render xml: @matches}
            format.json { render json: @matches}
        end

    end
    
    # GET /matches/1 or /matches/1.json
    def show
        # write match details to console
        puts "Match details:"
        puts "ID: " + @match.id.to_s
        puts "Date played: " + @match.date_played.to_s
        puts "Team 1: " + @match.team1_id.to_s
        puts "Team 2: " + @match.team2_id.to_s
        puts "Goals 1: " + @match.goals1.to_s
        puts "Goals 2: " + @match.goals2.to_s
        
    end
    
    # GET /matches/new
    def new
        @match = Match.new
        session[:saved_location] = request.referer

    end
    
    # GET /matches/1/edit
    def edit
    end
    
    # POST /matches or /matches.json
    def create
        @match = Match.new(match_params)
        
        respond_to do |format|
            if @match.save
                format.html { redirect_to match_url(@match), notice: "Match was successfully created." }
                format.json { render :show, status: :created, location: @match }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @match.errors, status: :unprocessable_entity }
            end
        end
    end
    
    # PATCH/PUT /matches/1 or /matches/1.json
    def update
        respond_to do |format|
            if @match.update(match_params)
                format.html { redirect_to match_url(@match), notice: "Match was successfully updated." }
                format.json { render :show, status: :ok, location: @match }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @match.errors, status: :unprocessable_entity }
            end
        end
        UpdatePointsJob.perform_later()
    end
    
    # DELETE /matches/1 or /matches/1.json
    def destroy
        @match.destroy
        
        respond_to do |format|
            format.html { redirect_to matches_url, notice: "Match was successfully destroyed." }
            format.json { head :no_content }
        end
    end
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
        @match = Match.find(params[:id])
    end
    
    # Only allow a list of trusted parameters through.
    def match_params
        params.require(:match).permit(
            :id,
            :date_played,
            :team1_id,
            :team2_id,
            :goals1,
            :goals2
        )
    end
end
