require 'test/unit'
require_relative 'division'

#-----------------------------
# is_prime_naive_V1: 6-9

def is_prime_naive_v1?(number)
  return false if number < 2
  (2...number).none? { |x| number % x == 0 }
end

#-----------------------------
# is_prime_naive: 15-18

def is_prime_naive?(number)
  return false if number < 2
  (2..).take_while { |x| x**2 <= number }.none? { |x| number % x == 0 }
end

