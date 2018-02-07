require './blockchain'
require 'sinatra'
require 'json'
require 'securerandom'

node_identifier = SecureRandom.uuid.gsub('-', '')

# Instantiate the blockchain
@blockchain = Blockchain.new

get '/mine' do
  "We'll mine a new Block"
end

post '/transactions/new' do
  "We'll add a new transaction"
end

get '/chain' do
  response = {
    chain: blockchain.chain,
    length: blockchain.chain.size
  }

  status 200
  body.response.to_json
end
