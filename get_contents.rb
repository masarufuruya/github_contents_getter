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
  req.url '/repos/masarufuruya/typescript_study/readme'
  req.headers['Authorization'] = 'bearer ' + token
end

response = res.body

res_ob = JSON.parse(response)
# puts res_ob
content = res_ob['content']

puts Base64.decode64(content)
