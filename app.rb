require 'sinatra'
require 'sinatra/reloader' # この記述によってサーバを再起動せずに変更を適用できる
require 'active_record' # ActiveRecordを使うために必要
require 'rack/csrf' # rack_csrfを使うために必要。csrf対策

use Rack::Session::Cookie, secret: "thisissomethingsecret"
use Rack::Csrf, raise: true

helpers do
  def csrf_tag
    Rack::Csrf.csrf_tag(env)
  end
  def csrf_token
    Rack::Csrf.csrf_token(env)
  end
  def h(str)
    Rack::Utils.escape_html(str)
  end
end

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: './bbs.db'
)

class Comment < ActiveRecord::Base
  validates :body, presence: true # 空のコメントができないようにcommentクラスにバリデーションを設定
end

get '/' do
  @title = "My BBS"
  @comments = Comment.all
  erb :index
end

post '/create' do
  Comment.create(body: params[:body])
  redirect to('/') #rootに転送
end

post '/destroy' do
  Comment.find(params[:id]).destroy
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
