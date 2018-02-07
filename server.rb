require './blockchain'
require 'sinatra'
require 'json'
require 'securerandom'

node_identifier = SecureRandom.uuid.delete('-', '')

# Instantiate the blockchain
@blockchain = Blockchain.new

get '/mine' do
  "We'll mine a new Block"
end

post '/transactions/new' do
  values = JSON.parse(request.body.read)

  required = ['sender', 'recipient', 'amount']
  
  unless required.all? { |s| values.key? s }
    status 400
    body = { message: 'Error: Missing values' }.to_json
    return
  end

  index = @blockchain.new_transaction(values['sender'], values['recipient'], values['amount'])

  response = { message: "Transaction will be added to Block #{index}" }

  status 201
  body response.to_json
end

get '/chain' do
  response = {
    chain: blockchain.chain,
    length: blockchain.chain.size
  }

  status 200
  body response.to_json
end
