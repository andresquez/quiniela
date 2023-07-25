class ApplicationApiController < ActionController::API
    include ActionController::MimeResponds
    
    # get token method
    def get_token
        payload = {
            user_id: 1,
            iat: Time.now.to_i,
            exp: Time.now.to_i + 60
        }
        token = JWT.encode(payload, Rails.application.credentials.jwt.hmac_secret, 'HS256')
        puts "this is the token" + token
        render json: { message: "Generated token", token: token }, status: :ok
    end
    
    # not found method
    def not_found
        render json: { error: 'not_found' }
    end
    
    # authorize request method
    def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
            decoded_token = JWT.decode(header, Rails.application.credentials.jwt.hmac_secret, true, { algorithm: 'HS256' })
            user_id = decoded_token[0]['user_id'] unless !decoded_token
            @current_user = Player.find(user_id)
        rescue ActiveRecord::RecordNotFound => e
            render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: { errors: e.message }, status: :unauthorized
        rescue JWT::ExpiredSignature => e
            render json: { errors: e.message }, status: :unauthorized
        end
    end
    
end
