require 'test/unit'
require_relative 'division'

#-----------------------------
# is_prime lines: 7-13, 26-32, 34-36, 15-18, 38-40, 20-23

PRIMES_UP_TO_100 = [
  2, 3, 5, 7, 11,
  13, 17, 19, 23, 29,
  31, 37, 41, 43, 47,
  53, 59, 61, 67, 71,
  73, 79, 83, 89, 97,
]

def is_prime_naive_v1?(number)
  return false if number < 2
  (2...number).none? { |x| number % x == 0 }
end

def is_prime_naive?(number)
  return false if number < 2
  (2..).take_while { |x| x**2 <= number }.none? { |x| number % x == 0 }
end

class TestIsPrime < Test::Unit::TestCase
  def assert_correct_primality_using(method)
    (-100..1).each { |x| assert !send(method, x) }

    primes, composites = (2..100).partition { |x| PRIMES_UP_TO_100.include? x }
    primes.each { |prime| assert send(method, prime) }
    composites.each { |composite| assert !send(method, composite) }
  end

  def test_is_prime_naive_v1
    assert_correct_primality_using :is_prime_naive_v1?
  end

  def test_is_prime_naive
    assert_correct_primality_using :is_prime_naive?
  end
end

