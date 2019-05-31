class Merchant
	attr_accessor :name, :discount_percentage

	def initialize(name, discount_percentage)
		@name= name
		@discount_percentage = discount_percentage
		p "#{@name} (#{discount_percentage})"
	end

	def update_discount(merchant, merchant_name, new_discount)
		merchant.discount_percentage = new_discount
		p "#{merchant.name} discount updated successfully"
	end

end