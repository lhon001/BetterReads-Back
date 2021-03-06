class ApplicationController < ActionController::API
  def issue_token(payload)
    JWT.encode(payload, secret)
  end

  def current_user
    # byebug
    User.find_by(id: decoded_token)
  end

  def token
    request.headers["Authorization"]
  end

  def decoded_token
    if token
      begin
        decoded = JWT.decode(token, secret)
        decoded[0]["id"]
      rescue JWT::DecodeError

      end
    else

    end
  end

  def secret
    "read2achieve"
  end

end
