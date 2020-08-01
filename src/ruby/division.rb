require 'test/unit'

TEST_INPUTS = [
  [6723, 220],
  [2392, 183],
  [788, 93],
  [582 * 11, 11],
  [46 * 82, 82],
]

DEFAULT_OPTIONS = {
  :include_negative => true,
  :include_reverse_order => true,
  :include_zero => true,
}

def test_inputs(**options)
  options = { **DEFAULT_OPTIONS, **options }
  result = TEST_INPUTS

  if options[:include_negative]
    result = result.flat_map { |(a, b)| [[a, b], [-a, b], [a, -b], [-a, -b]] }
  end
  if options[:include_reverse_order]
    result = result + result.map(&:reverse)
  end
  if options[:include_zero]
    result = result + result.flat_map { |(a, b)| [[a, 0], [0, b]] }
  end

  result
end

#-----------------------------
# divides?: lines 47-59, 37-44

def divides?(b, a)
  m = 0
  while m < a
    m += b
  end

  m == a
end

if false
  [
    [25, 0],
    [31, 432],
    [87, 87*58],
    [99, 9900],
    [9900, 99],
  ].each do |(b, a)|
    if divides?(b, a)
      puts "#{b} divides #{a}"
    else
      puts "#{b} does not divide #{a}"
    end
  end
end

#-----------------------------
# div_rem: lines 74-82, 65-71

def div_rem(a, b)
  rem = a % b
  rem += b.abs if rem < 0
  quo = (a - rem) / b

  [quo, rem]
end

class TestDivRem < Test::Unit::TestCase
  def test_div_rem
    test_inputs(:include_zero => false).each do |(a, b)|
      quo, rem = div_rem(a, b)

      assert 0 <= rem
      assert rem < b.abs
      assert_equal a, b*quo + rem
    end
  end
end

#-----------------------------
# naive_gcd: lines 88-98

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
# euclidean_algorithm: lines 112, 103-109

def euclidean_algorithm(a, b)
  while b != 0
    quo, rem = div_rem(a, b)
    puts "#{a} == #{b} * #{quo} + #{rem}"
    a, b = b, rem
  end
end

if false
  euclidean_algorithm(239847, 95832)
end

#-----------------------------
# gcd: lines 129-156, 118-126

def gcd(a, b)
  return if a == 0 && b == 0

  while b != 0
    a, b = b, a % b
  end

  a.abs
end

class TestGcd < Test::Unit::TestCase
  def test_gcd
    test_inputs.each do |(a, b)|
      d = gcd(a, b)
      assert d > 0
      assert a % d == 0
      assert b % d == 0
      assert_equal 1, gcd(a/d, b/d)
    end
  end

  def test_gcd_explicit
    assert_nil gcd(0, 0)

    [[10, 0], [-10, 0]].each do |(a, b)|
      assert_equal 10, gcd(a, b)
      assert_equal 10, gcd(b, a)
    end

    [[6, 3], [-6, 3], [6, -3], [-6, -3]].each do |(a, b)|
      assert_equal 3, gcd(a, b)
      assert_equal 3, gcd(b, a)
    end

    [[322, 70], [-322, 70], [322, -70], [-322, -70]].each do |(a, b)|
      assert_equal 14, gcd(a, b)
      assert_equal 14, gcd(b, a)
    end
  end
end

#-----------------------------
# bezout: lines 179-188, 162-176

def bezout(a, b)
  return if a == 0 && b == 0

  prev, curr = [[1, 0], [0, 1]]

  while b != 0
    quo, rem = div_rem(a, b)
    nxt = [0, 1].map { |i| prev[i] - curr[i] * quo }

    a, b = b, rem
    prev, curr = curr, nxt
  end

  a < 0 ? prev.map { |u| -u } : prev
end

class TestBezout < Test::Unit::TestCase
  def test_bezout
    test_inputs.each do |(a, b)|
      x, y = bezout(a, b)
      assert_equal gcd(a, b), a * x + b * y
    end
  end

  def test_bezout_explicit
    assert_nil bezout(0, 0)
  end
end

#-----------------------------
# naive_lcm: lines 194-205

def naive_lcm(a, b)
  return if a == 0 || b == 0

  smaller, larger = [a, b].map(&:abs).sort

  multiple = larger
  while multiple % smaller != 0
    multiple += larger
  end

  multiple
end

#-----------------------------
# lcm: lines 219- 227, 236-240

class TestLcm < Test::Unit::TestCase
  def limited_test_inputs
    test_inputs(
      :include_zero => false,
      :include_negative => false,
      :include_reverse => false
    )
  end

  def test_lcm
    limited_test_inputs.each do |(a, b)|
      assert_equal naive_lcm(a, b), lcm(a, b)
    end

    test_inputs(:include_zero => false).each do |(a, b)|
      assert_equal (a * b).abs, gcd(a, b) * lcm(a, b)
    end
  end

  def test_lcm_explicit
    [[5, 0], [0, 5], [0, 0]].each do |(a, b)|
      assert_nil lcm(a, b)
    end
  end
end

def lcm(a, b)
  return if a == 0 || b == 0

  ((a / gcd(a, b)) * b).abs
end

