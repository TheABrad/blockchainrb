require './blockchain'
require 'sinatra'
require 'json'
require 'securerandom'

node_identifier = SecureRandom.uuid.delete('-', '')

# Instantiate the blockchain
@blockchain = Blockchain.new

get '/mine' do
  # Proof of Work algorithm to get next proof
  last_block = @blockchain.last_block
  last_proof = last_block[:proof]
  proof = @blockchain.proof_of_work(last_proof)

  @blockchain.new_transaction(
    sender = "0",
    recipient = node_identifier,
    amount = 1
  )

  block = @blockchain.new_block(proof)

  response = {
    message: 'New Block Forged',
    index: block[:index],
    transactions: block[:transactions],
    proof: block[:proof],
    previous_hash: block[:previous_hash]
  }

  status 200
  body response.to_json
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
