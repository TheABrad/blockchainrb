require 'digest'
require 'json'

class Blockchain
  
  attr_acessor :chain

  def initialize
    @chain = []
    @current_transactions = []

    new_block(100, 1)
  end

  def new_block(proof, previous_hash = nil)
    block = {
      index: @chain.length + 1,
      timestamp: Time.now,
      transactions: @current_transactions,
      proof: proof,
      previous_hash: previous_hash || hash(last_block)
    }

    # reset the current list of transactions
    @current_transactions = []

    @chain << block
    block
  end

  def new_transaction(sender, recipient, amount)
    @current_transactions << {
      sender: sender,
      recipient: recipient,
      amount: amount
    }

    last_block[:index] + 1
  end

  def hash(block)
    block_string = block.sort.to_h.to_json
    Digest::SHA256.hexdigest block_string
  end

  def last_block
    @chain[-1]
  end
end
