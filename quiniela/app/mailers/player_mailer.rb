class PlayerMailer < ApplicationMailer

    def welcome_player_email
        @player = params[:player]
        mail(to: 'receiver@gmail.com', subject: 'Welcome to the team!', from: 'sender@gmail.com')
    end

end
