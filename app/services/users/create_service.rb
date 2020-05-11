module Users
  class CreateService
    prepend BasicService

    param :name
    param :email
    param :password

    attr_reader :user

    def call
      @user = User.new(
        name: @name,
        email: @email,
        password: @password
      )

      fail!(@user.errors) unless @user.save
    end
  end
end
