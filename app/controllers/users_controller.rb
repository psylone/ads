class UsersController < ApplicationController
  def create
    result = Users::CreateService.call(*user_params)

    if result.success?
      head :created
    else
      error_response(result.user, :unprocessable_entity)
    end
  end

  private

  def user_params
    params.require(%i[name email password])
  end
end
