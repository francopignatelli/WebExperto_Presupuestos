module Api
    module V1
      class AuthenticationController < ApplicationController
        skip_before_action :verify_authenticity_token, only: :login
        def login
          user = User.find_by(email: params[:email])
  
          if user&.valid_password?(params[:password])
            token = user.generate_jwt
            render json: { token: token }
          else
            render json: { error: 'No te detecto las credenciales loquito' }, status: :unauthorized
          end
        end
      end
    end
  end