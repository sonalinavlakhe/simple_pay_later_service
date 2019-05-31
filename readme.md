# Simple Pay-Later Service

As a pay later service we allow our users to buy goods from a merchant now, and then allow
them to pay for those goods at a later date.


The service works inside the boundary of following simple constraints -

* Let's say that for every transaction paid through us, merchants offer us a discount.
  * For example, if the transaction amount is Rs.100, and merchant discount offered
    to us is 10%, we pay Rs. 90 back to the merchant.
  * The discount varies from merchant to merchant.
  * A merchant can decide to change the discount it offers to us, at any point in time.
  
* All users get onboarded with a credit limit, beyond which they can't transact.
  * If a transaction value crosses this credit limit, we reject the transaction.
  

## Use Cases

There are various use cases our service is intended to fulfil -

* allow merchants to be onboarded with the amount of discounts they offer
* allow merchants to change the discount they offer
* allow users to be onboarded (name, email-id and credit-limit)
* allow a user to carry out a transaction of some amount with a merchant.
* allow a user to pay back their dues (full or partial)
* Reporting:
  * how much discount we received from a merchant till date
  * dues for a user so far
  * which users have reached their credit limit
  * total dues from all users together
  

## CLI

Run application - 

ruby simple_pay_later_service.rb sample_input.txt

**sample_input.txt**

new user user1 u1@users.com 300<br />
new user user2 u2@users.com 400 <br />
new user user3 u3@users.com 500<br />
new merchant m1 0.5%<br />
new merchant m2 1.5%<br />
new merchant m3 1.25%<br />
new txn user2 m1 500<br />
new txn user1 m2 300<br />
new txn user1 m3 10<br />
report users-at-credit-limit<br />
new txn user3 m3 200<br />
new txn user3 m3 300<br />
report users-at-credit-limit<br />
report discount m3<br />
payback user3 400<br />
report total-dues<br />

**Output**

user1 (300)<br />
user2 (400)<br />
user3 (500)<br />
"m1 (0.5%)"<br />
"m2 (1.5%)"<br />
"m3 (1.25%)"<br />
rejected! (reason: credit limit)<br />
Sucess!<br />
rejected! (reason: credit limit)<br />
user1<br />
Sucess!<br />
Sucess!<br />
user1<br />
user3<br />
6.25<br />
user3(dues 100)<br />
300<br /><br />
400<br />



