require 'sinatra'
require 'sinatra/reloader' # この記述によってサーバを再起動せずに変更を適用できる

get '/' do
  @title = "My Site"
  erb :index
end

# :〇〇, params[:〇〇]でURLで指定した値を表示できる
# get '/hello/:name' do
#   "hello #{params[:name]}"
# end

# ブロック変数を使えばparamsを使わなくていい
# get '/hello/:name' do |name|
#   "hello #{name}"
# end

# 値は複数指定できる。ブロック変数も複数利用可能
# get '/hello/:fname/:lname' do |f, l|
#   "hello #{f} #{l}"
# end

# ?をつけることにより、値がなくてもエラーにならない
# get '/hello/:fname/?:lname?' do |f, l|
#   "hello #{f} #{l}"
# end

# ワイルドカードの*を使うこともできる
# get '/hello/*/*' do |f, l|
#   "hello #{f} #{l}"
# end

# paramsを使った書き方
# get '/hello/*/*' do
#   "hello #{params[:splat][0]} #{params[:splat][1]}"
# end

# 正規表現を使うには、%rを用いる
# get %r{/users/([0-9]*)} do
#   "user id = #{params[:captures][0]}" # ()の部分をparams[:captures]で表示できる
# end
