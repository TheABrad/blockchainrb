class Blockchain
  
  attr_acessor :chain

  def initialize
    @chain = []
    @current_transactions = []
  end

  def new_block

  end

  def new_transaction(sender, recipient, amount)
    @current_transactions << {
      sender: sender,
      recipient: recipient,
      amount: amount
    }

    return last_block[:index] + 1
  end

  def hash(block)

  end

  def last_block

  end
end
