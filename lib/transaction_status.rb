class TransactionStatus
	attr_accessor :user, :transaction_amount, :payment_due_amount, :updated_credit_limit, :payment_amount

	def initialize(user, transaction_amount, credit_limit)
		@user = user
		@transaction_amount = transaction_amount.to_i
		@payment_due_amount = 0
		@updated_credit_limit = credit_limit
		@payment_amount = 0
	end

end