class SessionsController < ApplicationController
  skip_before_action :auth_user, only: %i[create]

  def create
    result = UserSessions::CreateService.call(*session_params)

    if result.success?
      token = JwtEncoder.encode(uuid: result.session.uuid)
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
