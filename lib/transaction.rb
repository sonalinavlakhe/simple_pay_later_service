class Transaction
	attr_accessor :user, :merchant, :amount, :discount_amount

	def initialize(user, merchant, amount, discount_percentage)
		@user = user
		@merchant = merchant
		@amount = amount.to_i
		@discount_amount = (@amount * discount_percentage.to_f)/100
	end
end