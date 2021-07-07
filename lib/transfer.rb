class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status
  def initialize sender, receiver, amount, status = 'pending'
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = status
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if self.status == "pending" && valid? && sender.balance > amount
      sender.balance -= amount
      receiver.balance += amount
      self.status = "complete"
    else
      reject_transaction
    end  
  end

  def reject_transaction
    self.status = "rejected"
    "Transaction rejected. Please check your account balance."
  end

  def reverse_transfer
      if self.status == 'complete'
        sender.balance += amount
        receiver.balance -= amount
        self.status = "reversed"
      end  
  end

  
end
