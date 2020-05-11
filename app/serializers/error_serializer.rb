module ErrorSerializer
  extend self

  def from_messages(error_messages, meta: {})
    error_messages = Array.wrap(error_messages)
    { errors: build_errors(error_messages, meta) }
  end
  alias from_message from_messages

  def from_model(model)
    { errors: build_model_errors(model.errors) }
  end

  private

  def build_errors(error_messages, meta)
    error_messages.map { |message| build_error(message, meta) }
  end

  def build_model_errors(errors)
    errors.messages.map do |key, messages|
      messages.map do |message|
        error = build_error(message)
        error[:source] = { pointer: "/data/attributes/#{key}" }
        error
      end
    end.flatten
  end

  def build_error(message, meta = {})
    error = { detail: message }
    error[:meta] = meta if meta.present?
    error
  end
end
