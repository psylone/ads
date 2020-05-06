module RequestHelpers
  def response_body
    JSON(response.body)
  end
end
