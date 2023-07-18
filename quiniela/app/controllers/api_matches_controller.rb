class ApiMatchesController < ApplicationApiController
    
    before_action :set_match, only: %i[ show edit update destroy ]
    # skip_before_action :verify_authenticity_token
    
    # GET api/api_matches or api/api_matches.json
    def index
        @matches = Match.all

        respond_to do |format|
            format.json { render json: @matches}
            format.xml { render xml: @matches}
        end


    end
    
    # GET api/api_matches/1 or api/api_matches/1.json
    def show
        respond_to do |format|
            format.json { render json: @match}
            format.xml { render xml: @match}
        end
        
    end
    
    # GET api/api_matches/new
    def new
        @match = Match.new
        respond_to do |format|
            format.xml { render xml: @match}
            format.json { render json: @match}
        end
    end
    
    # GET api/api_matches/1/edit
    def edit
        respond_to do |format|
            format.xml { render xml: @match}
            format.json { render json: @match}
        end
    end
    

    # POST api/api_matches or api/api_matches.json
    # example query:
    # "http://localhost:3000/api/api_matches?date_played=2021-06-11&team1_id=1&team2_id=2&goals1=1&goals2=2"
    # example body of request:
    # {
    #     "date_played": "2021-06-11",
    #     "team1_id": 1,
    #     "team2_id": 2,
    #     "goals1": 1,
    #     "goals2": 2
    # }

    def create
        @match = Match.new(match_params)
        
        respond_to do |format|
            if @match.save
                format.json { render json:@match, status: :created }
                format.xml { render json:@match, status: :created }
            else
                format.json { render json: @match.errors, status: :unprocessable_entity }
                format.xml { render json: @match.errors, status: :unprocessable_entity }
            end
        end
    end
    
    # PATCH/PUT api/api_matches/1 or api/api_matches/1.json
    # example query:
    # "http://localhost:3000/api/api_matches/1?goals1=1&goals2=2" 
    # example body of request:
    # {
    #     "goals1": 1,
    #     "goals2": 2
    # }
    def update
        respond_to do |format|
            if @match.update(match_params)
                format.json { render :show, status: :ok, location: @match }
                format.xml { render :show, status: :ok, location: @match }
            else
                format.json { render json: @match.errors, status: :unprocessable_entity }
                format.xml { render json: @match.errors, status: :unprocessable_entity }
            end
        end
        UpdatePointsJob.perform_later()
    end
    
    # DELETE api/api_matches/1 or api/api_matches/1.json
    def destroy
        @match.destroy
        
        respond_to do |format|
            format.json { head :no_content }
            format.xml { head :no_content }
        end
    end
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
        @match = Match.find(params[:id])
    end
    
    # Only allow a list of trusted parameters through.
    def match_params
        params.require(:match).permit(:id, :date_played, :team1_id, :team2_id, :goals1, :goals2)
    end
end