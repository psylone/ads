module ApiErrors
  extend ActiveSupport::Concern

  included do
    rescue_from(StandardError) { |e| handle_exception(e) }
  end

  private

  def handle_exception(e)
    case e
    when ActiveRecord::RecordNotFound
      error_response(I18n.t(:not_found, scope: 'api.errors'), :not_found)
    when ActiveRecord::RecordNotUnique
      error_response(I18n.t(:not_unique, scope: 'api.errors'), :unprocessable_entity)
    when ActionController::ParameterMissing, KeyError
      error_response(I18n.t(:missing_parameters, scope: 'api.errors'), :unprocessable_entity)
    else
      raise
    end
  end

  def error_response(error_messages, status)
    errors = case error_messages
    when ActiveRecord::Base
      ErrorSerializer.from_model(error_messages)
    else
      ErrorSerializer.from_messages(error_messages)
    end

    render json: errors, status: status
  end
end
