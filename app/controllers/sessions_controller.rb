class SessionsController < ApplicationController
  include JwtEncoder

  def create
    result = UserSessions::CreateService.call(*session_params)

    if result.success?
      token = encode_jwt(result.session.uuid)
      meta = { token: token }

      render json: { meta: meta }, status: :created
    else
      error_response(result.session || result.errors, :unauthorized)
    end
  end

  private

  def session_params
    params.require(%i[email password])
  end
end
