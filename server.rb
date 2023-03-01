require "sinatra"
require "sinatra/reloader" if development?
require "sinatra/json"
require "json"
require "pry" if development? || test?

set :bind, '0.0.0.0'  # bind to all interfaces
set :port, 3000
set :public_folder, File.join(File.dirname(__FILE__), "public")
set :views, File.dirname(__FILE__) + "/views"

def read_dishes
  JSON.parse(File.read("dishes.json"))
end

get "/" do
  redirect "/dishes"
end

get "/dishes" do
  erb :home
end

# API ENDPOINTS
get "/api/v1/dishes" do
  # retrieve dishes from json
  dishes = read_dishes

  # set response type to json for clarity
  content_type :json

  # send back a json response of dishes
  json dishes
end


# SINATRA VIEWS ROUTES
get "*" do
  erb :home
end
