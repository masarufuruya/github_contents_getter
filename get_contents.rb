# coding: utf-8
require "faraday"
require "base64"
require "json"

# Githubトークンを環境変数から取得
token = ENV["TOKEN"]
p token

conn = Faraday::Connection.new(:url => "https://api.github.com") do |builder|
    ## URLをエンコードする
    builder.use Faraday::Request::UrlEncoded
    ## ログを標準出力に出したい時(本番はコメントアウトでいいかも)
    builder.use Faraday::Response::Logger
    ## アダプター選択（選択肢は他にもあり）
    builder.use Faraday::Adapter::NetHttp
end

commit_ref = "9b4f8efd700d13777bf725abef9567f186fdf72c"

res = conn.get do |req|
  # req.url "/repos/masarufuruya/hackwith/contents/app/controllers/top_controller.rb?ref=#{commit_ref}"
  req.url "/repos/masarufuruya/github_contents_getter/contents/get_contents.rb?ref=#{commit_ref}"
  req.headers["Authorization"] = "bearer " + token
end

# json decode ruby object
response = res.body
res_ob = JSON.parse(response)

# get by hash key content
content = res_ob["content"]
# decode base64
puts Base64.decode64(content)
