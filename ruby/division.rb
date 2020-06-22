require 'test/unit'

#-----------------------------
# divides?: lines 15-29, 6-13

def divides?(b, a)
  m = 0
  while m < a
    m += b
  end

  m == a
end

DIVIDES_TEST_INPUTS = [
  [25, 0],
  [31, 432],
  [87, 87*58],
  [99, 9900],
  [9900, 99],
]

DIVIDES_TEST_INPUTS.each do |(b, a)|
  if divides?(b, a)
    puts "#{b} divides #{a}"
  else
    puts "#{b} does not divide #{a}"
  end
end

#-----------------------------
# div_rem: lines 41-61, 34-39

def div_rem(a, b)
  rem = (a % b) + (b < 0 ? -b : 0)
  quo = (a - rem) / b

  [quo, rem]
end

DIV_REM_TEST_INPUTS = [
  [6723, 220],
  [-2392, 183],
  [788, -93],
  [-5853, -11],
  [46 * 82, 82],
]

class TestDivRem < Test::Unit::TestCase
  def test_div_rem
    DIV_REM_TEST_INPUTS.each do |(a, b)|
      quo, rem = div_rem(a, b)

      assert 0 <= rem
      assert rem < b.abs
      assert_equal a, b*quo + rem

      puts "#{a} == #{b} * #{quo} + #{rem}"
    end
  end
end

#-----------------------------
# naive_gcd: lines 66-76

def naive_gcd(a, b)
  divisor = 1
  upper_bound = [a.abs, b.abs].min
  (2..upper_bound).each do |i|
    if a % i == 0 && b % i == 0
      divisor = i
    end
  end

  divisor
end

#-----------------------------
# euclidean_algorithm: lines 89, 81-87

def euclidean_algorithm(a, b)
  while b != 0
    quo, rem = div_rem(a, b)
    puts "#{a} == #{b} * #{quo} + #{rem}"
    a, b = b, rem
  end
end

euclidean_algorithm(239847, 95832)

#-----------------------------
# gcd: lines 104-141, 94-102

def gcd(a, b)
  return if a == 0 && b == 0

  while b != 0
    a, b = b, a % b
  end

  a.abs
end

GCD_TEST_INPUTS = [
  [6723, 220],
  [-2392, 183],
  [788, -93],
  [-5853, -11],
  [46 * 82, 82],
]

class TestGcd < Test::Unit::TestCase
  def test_gcd
    GCD_TEST_INPUTS.each do |(a, b)|
      d = gcd(a, b)
      assert d > 0
      assert a % d == 0
      assert b % d == 0
      assert_equal 1, gcd(a/d, b/d)
    end
  end

  def test_gcd_explicit
    assert_nil gcd(0, 0)

    assert_equal 5, gcd(5, 0)
    assert_equal 5, gcd(-5, 0)
    assert_equal 5, gcd(0, 5)
    assert_equal 5, gcd(0, -5)

    assert_equal 3, gcd(6, 3)
    assert_equal 3, gcd(-6, 3)
    assert_equal 3, gcd(6, -3)
    assert_equal 3, gcd(-6, -3)

    assert_equal 14, gcd(322, 70)
    assert_equal 14, gcd(-322, 70)
    assert_equal 14, gcd(322, -70)
    assert_equal 14, gcd(-322, -70)
  end
end
