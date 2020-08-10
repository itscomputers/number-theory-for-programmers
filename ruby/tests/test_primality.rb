require_relative '../primality'

#-----------------------------
# primes < 100: 6-12

PRIMES_UP_TO_100 = [
  2, 3, 5, 7, 11,
  13, 17, 19, 23, 29,
  31, 37, 41, 43, 47,
  53, 59, 61, 67, 71,
  73, 79, 83, 89, 97,
]

class TestIsPrime < Test::Unit::TestCase

  #---------------------------
  # primality assertion: 19-25

  def assert_correct_primality_using(method)
    (-100..1).each { |x| assert !send(method, x) }

    primes, composites = (2..100).partition { |x| PRIMES_UP_TO_100.include? x }
    primes.each { |prime| assert send(method, prime) }
    composites.each { |composite| assert !send(method, composite) }
  end

  #---------------------------
  # prime naive v1: 30-32

  def test_is_prime_naive_v1
    assert_correct_primality_using :is_prime_naive_v1?
  end

  #---------------------------
  # prime naive: 37-39

  def test_is_prime_naive
    assert_correct_primality_using :is_prime_naive?
  end
end

