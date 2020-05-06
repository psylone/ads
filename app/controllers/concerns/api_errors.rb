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
    else
      raise
    end
  end

  def error_response(message, status)
    errors = ErrorSerializer.from_message(message)
    render json: errors, status: status
  end
end
