module UserSessions
  class CreateService
    prepend BasicService

    param :email
    param :password
    option :user, default: proc { User.find_by(email: @email) }, reader: false

    attr_reader :session

    def call
      validate
      create_session unless failure?
    end

    private

    def validate
      return fail_t!(:unauthorized) unless @user&.authenticate(@password)
    end

    def create_session
      @session = @user.sessions.new
      fail!(@session.errors) unless @session.save
    end

    def fail_t!(key)
      fail!(I18n.t(key, scope: 'services.user_sessions.create_service'))
    end
  end
end
