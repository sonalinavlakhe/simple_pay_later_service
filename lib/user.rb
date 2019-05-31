class User
	attr_accessor :name, :email, :credit_limit

	def initialize(name, email, credit_limit)
		@name = name
		@email = email
		@credit_limit = credit_limit.to_i
		puts "#{name} (#{credit_limit})"
  end

end