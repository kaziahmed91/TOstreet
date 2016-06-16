set :partial_template_engine, :erb
enable :partial_underscores

# captures.rb

post 'posts/new' do
  @street1 = params[:street1]
  @street2 = params[:street2]
  @post = Posts.find_all_by_address(@street1, @street2).first

  if @post
    new_post(@post)
  else
    new_intersection(@post)
  end
end

def new_post(post)
  @post = Post.new(
    post_id: post.id,
    artist_name: params[:artist_name],
    user_id: params[:user_id],
    url: params[:url],
    link: params[:link],
    text: params[:text]
  )
  @post.save
  redirect '/user_page'
end

def new_capture(_post)
  @new_post = post.new(
    street1: params[:street1],
    street2: params[:street2]
  )
  @new_post.save

  new_capture(@new_post)
end

post '/captures/:capture_id/delete' do
  capture = Capture.find params[:capture_id]
  if capture.user_id == current_user.id
    capture.destroy
    redirect :"/user_page"
  else
    erb :"/"
  end
end

get '/user_page/:user_id/captures' do
  @captures = Capture.all
end

get '/user_page' do
  @captures = current_user.captures
  erb :user_page
end

# user.rb
get '/' do
  @captures = Capture.all
  erb :index
end

def current_user
  # if the user has a remember cookie set...automatically log them in
  if cookies.key? :remember_me
    user = User.find_by_remember_token(cookies[:remember_me])
    return user if user
  end

  if session.key?(:user_session)
    user = User.find_by_login_token(session[:user_session])
  end
end

get '/login' do
  if current_user
    redirect :user_page
  else
    erb :login
  end
end

get '/logout' do
  if current_user
    session.clear
    redirect :/
  end
end

post '/session' do
  @user = User.find_by_email(params[:email])
  if @user && @user.authenticate(params[:password])
    session[:user_session] = SecureRandom.hex
    @user.login_token = session[:user_session]

    if params.key?('remember_me') && params[:remember_me] == 'true'

      if @user.remember_token
        response.set_cookie :remember_me, value: @user.remember_token, max_age: '2592000'
      else
        response.set_cookie :remember_me, value: SecureRandom.hex, max_age: '2592000'
        @user.remember_token = cookies[:remember_me]
      end
    end

    @user.save

    # redirect to next_url if available
    if cookies.key? :next_url
      redirect cookies.delete(:next_url)
    else
      redirect '/user_page'
    end

  else
    erb :login
  end
end

# captures
post '/search' do
  @street1 = params[:street1]
  @street2 = params[:street2]
  @posts = post.find_all_by_address(@street1, @street2)
  puts @posts
  erb :search
end

get '/user/:user_id/captures' do
  @captures = User.find params[:user_id].captures
  @captures.order('created_at DESC')
  erb :user_page
  order by captures created_at (descending order)
end

# get '/art_page' do
#   @captures = capture.joins(:post).where('post.id = post_id')
#   @captures.order created_at.desc
#
#   # ordered by most recent
#   erb :art_page
# end

# get '/post/:post_id/captures/' do
#   @post = post.find params[:post_id].captures
#   @post.order('created_at DESC').first
#   erb :user_page
#   # order by created_at (descending order)
# end
