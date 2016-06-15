
post '/comments' do
  @comment = Comment.new(
    artist_name: params[:artist_name],
    url: params[:url],
    link: params[:link],
    text: params[:text]
  )
  @comment.save
  @comments = @comment.all
  erb :user_page
end

get '/user_page' do
  @comment = Comment.all
  erb :user_page
end
