# coding: utf-8
require "faraday"
require "base64"
require "json"

# Githubトークンを環境変数から取得
token = ENV['TOKEN']

conn = Faraday::Connection.new(:url => 'https://api.github.com') do |builder|
    ## URLをエンコードする
    builder.use Faraday::Request::UrlEncoded
    ## ログを標準出力に出したい時(本番はコメントアウトでいいかも)
    builder.use Faraday::Response::Logger
    ## アダプター選択（選択肢は他にもあり）
    builder.use Faraday::Adapter::NetHttp
end

res = conn.get do |req|
  req.url '/repos/masarufuruya/typescript_study/contents/five_mininues.html?ref=86af399afebdd9fdcdd91430918e56ce2bad7bb5'
  req.headers['Authorization'] = 'bearer ' + token
end

# json decode ruby object
response = res.body
res_ob = JSON.parse(response)

# get by hash key content
content = res_ob['content']
# decode base64
puts Base64.decode64(content)
