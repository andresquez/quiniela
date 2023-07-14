# Preview all emails at http://localhost:3000/rails/mailers/player_mailer
class PlayerMailerPreview < ActionMailer::Preview
    def welcome_player_email
        PlayerMailer.with(player: Player.first).welcome_player_email
    end
end
