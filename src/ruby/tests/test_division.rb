require_relative '../division'

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
# not real tests, but used for output in book

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

if false
  euclidean_algorithm(239847, 95832)
end

#-----------------------------
# tests for division.rb

class TestDivision < Test::Unit::TestCase

  #---------------------------
  # test div_rem 65-73

  def test_div_rem
    test_inputs(:include_zero => false).each do |(a, b)|
      quo, rem = div_rem(a, b)

      assert 0 <= rem
      assert rem < b.abs
      assert_equal a, b*quo + rem
    end
  end

  #---------------------------
  # test gcd 78-105

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

  #---------------------------
  # test bezout 110-119

  def test_bezout
    test_inputs.each do |(a, b)|
      x, y = bezout(a, b)
      assert_equal gcd(a, b), a * x + b * y
    end
  end

  def test_bezout_explicit
    assert_nil bezout(0, 0)
  end

  #---------------------------
  # test lcm 124-144

  def test_lcm_against_naive
    test_inputs(
      :include_zero => false,
      :include_negative => false,
      :include_reverse => false
    ).each do |(a, b)|
      assert_equal naive_lcm(a, b), lcm(a, b)
    end
  end

  def test_lcm
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



