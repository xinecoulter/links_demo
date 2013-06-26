require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do
  erb :home
end

get '/about' do
  "This is me"
end

get '/new_link' do
  erb :new_link
end

post '/new_link' do
  @link_name = params[:name]
  @link = params[:link]
  f = File.new('links.csv', 'a+')
  f.puts("#{@link_name},#{@link}")
  f.close
  redirect to("/links")
end

get '/links' do
  link_file = File.new('links.csv', 'r')
  @links = []
  link_file.each do |line|
    @links << line.split(',')
  end
  link_file.close
  erb :links
end

post '/navigate' do
  case params[:destination].downcase
    when "links" then redirect to("/links")
    when "about" then redirect to ("/about")
  end
  redirect to("/")
end








# get '/manual_links' do
#   @links = ['http://reddit.com',
#             'http://news.ycombinator.com',
#             'http://techcrunch.com',
#             'http://macrumors.com',
#             'http://gizmodo.com']
#   erb :links
# end