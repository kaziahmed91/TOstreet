post '/comments' do
  @comment = Comment.new(
    artist_name: params[:artist_name],
    url: params[:url],
    link: params[:link],
    text: params[:text]
  )
  @comment.save
  erb :user_page
end

get '/user_page' do
  erb :user_page
end
