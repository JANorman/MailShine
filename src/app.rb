require 'sinatra'
require 'json'
require 'premailer'

set :bind, '0.0.0.0'

post '/mail' do
    body = request.body.read.to_s
    premailer = Premailer.new(body, {:with_html_string => true});
    content_type :json
    { 
        :result => premailer.to_inline_css,
        :warnings => premailer.warnings
    }.to_json
end