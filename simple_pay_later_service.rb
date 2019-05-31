Dir["./lib/*.rb"].each {|file| require file }
require 'pry'



def process_inputs(inputs)
  @merchants = []
  @users = []
  @transactions =[]
  @transaction_status = []
  @payments = []

  inputs.split("\n").each do |input|
    sliced_input = input.split(/\s/)
    command = sliced_input[0]
    if command == 'new'
      case type =  sliced_input[1]
      when 'user'
        @users << User.new(sliced_input[2], sliced_input[3], sliced_input[4])
      when 'merchant'
        @merchants <<  Merchant.new(sliced_input[2], sliced_input[3])
      when 'txn'
        user = @users.select{|user| user.name == sliced_input[2] }.first
        if user
          transaction_exists = @transaction_status.any? {|transaction_status| transaction_status.user == sliced_input[2]}
          if transaction_exists
            transaction_status = @transaction_status.select{ |transaction_status| transaction_status.user == user.name}.first
            payment_due_amount = transaction_status.payment_due_amount + sliced_input[4].to_i
            updated_credit_limit = transaction_status.updated_credit_limit - sliced_input[4].to_i
          else
            transaction_status =  TransactionStatus.new(sliced_input[2],sliced_input[4], user.credit_limit)
            payment_due_amount = sliced_input[4].to_i
            updated_credit_limit = user.credit_limit - sliced_input[4].to_i
          end

          if sliced_input[4].to_i <= transaction_status.updated_credit_limit
            transaction_status.transaction_amount = sliced_input[4].to_i
            transaction_status.payment_due_amount = payment_due_amount
            transaction_status.updated_credit_limit = updated_credit_limit
            @transaction_status << transaction_status unless transaction_exists
            merchant = @merchants.select { |merchant| merchant.name == sliced_input[3] }.first
            @transactions << Transaction.new(user.name, sliced_input[3], sliced_input[4], merchant.discount_percentage)
            puts "Sucess!"
          else
            puts "rejected! (reason: credit limit)"
          end
        else
          puts "User not exists"
        end
      else
        puts "No command Found"
      end
    elsif command == 'update'
      merchant = @merchants.select {|merchant| merchant.name == sliced_input[2]}.first
        if merchant
          merchant.update_discount(merchant, sliced_input[2], sliced_input[3])
        else
          puts "MERCHANT NOT AVAILABLE"
        end
    elsif command == 'payback'
      user = @users.select{|user| user.name == sliced_input[1] }.first
      transaction_exists = @transaction_status.any? {|transaction_status| transaction_status.user == sliced_input[1]}
      if transaction_exists
        transaction_status = @transaction_status.select{ |transaction_status| transaction_status.user == user.name}.first
        if sliced_input[2].to_i <= transaction_status.payment_due_amount
          payment_due_amount = transaction_status.payment_due_amount - sliced_input[2].to_i
          updated_credit_limit = transaction_status.updated_credit_limit + sliced_input[2].to_i
          transaction_status.payment_amount = sliced_input[4].to_i
          transaction_status.payment_due_amount = payment_due_amount
          transaction_status.updated_credit_limit = updated_credit_limit
          @payments << Payment.new(user.name, sliced_input[4])
          puts "#{user.name}(dues #{payment_due_amount})"
        else
          puts "you have to pay #{transaction_status.payment_due_amount}"
        end
      end
    elsif command == 'report'
      case type =  sliced_input[1]
      when 'discount'
        total_discount = 0
        @transactions.each do |transaction|
          if transaction.merchant == sliced_input[2]
            total_discount = total_discount + transaction.discount_amount
          end
        end
        puts "#{total_discount}"
      when 'dues'
        @transaction_status.each do |transaction_status|
          if transaction_status.user == sliced_input[2]
            puts "#{transaction_status.payment_due_amount}"
          end
        end
      when 'users-at-credit-limit'
        @transaction_status.each do |transaction_status|
          if transaction_status.payment_due_amount ==  @users.select{|user| user.name == transaction_status.user }.first.credit_limit
            puts "#{transaction_status.user}"
          else
            puts "NO User exists"
          end
        end
      else 'total-dues'
        total_dues= 0
        @transaction_status.each do |transaction_status|
          total_dues = total_dues + transaction_status.payment_due_amount
          puts "#{total_dues}"
        end
      end
    end
  end
end

def main
  inputs = File.read(ARGV[0])
  process_inputs(inputs)
end

main()