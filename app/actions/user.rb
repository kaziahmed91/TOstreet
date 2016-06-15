class User < ActiveRecord::Base
  has_secure_password
  has_many :comments

  get '/login' do
    erb :login
  end

  def current_user
    # if the user has a remember cookie set...automatically log them in
    if cookies.has_key? :remember_me
      user = User.find_by_remember_token(cookies[:remember_me])
      return user if user
    end

    if session.has_key?(:user_session)
      user = User.find_by_login_token(session[:user_session])
    else
      nil
    end
  end

  get '/secure' do
    if current_user
      erb :user_page
    else
      redirect '/login'
    end
  end

  post '/session' do
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_session] = SecureRandom.hex
      @user.login_token = session[:user_session]

      if params.has_key?('remember_me') && params[:remember_me] == 'true'

        if @user.remember_token
          response.set_cookie :remember_me, {value: @user.remember_token, max_age: "2592000" }
        else
          response.set_cookie :remember_me, {value: SecureRandom.hex, max_age: "2592000" }
          @user.remember_token = cookies[:remember_me]
        end
      end

      @user.save

      # redirect to next_url if available
      if cookies.has_key? :next_url
        redirect cookies.delete(:next_url)
      else
        redirect '/user_page'
      end

    else
      erb :login
    end
  end

end
