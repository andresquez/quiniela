# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
    before_action :set_current_player
  
    private
  
    def set_current_player
      if session[:player_id]
        @current_player = Player.find_by(id: session[:player_id])
      else
        redirect_to login_players_path, alert: "Please log in to continue."
      end
    end
  end
  