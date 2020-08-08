require 'test/unit'
require_relative 'division'

#-----------------------------
# linear equation solver: lines 40-65, 7-37

class LinearEquationSolver
  # class to find integer solutions [x, y] to a*x + b*y == c

  def initialize(a, b, c)
    @a = a
    @b = b
    @c = c

    @d = gcd(a, b)
    @delta_x = b / @d
    @delta_y = -a / @d
    @multiplier, @remainder = div_rem(c, @d)
  end

  def solvable?
    @remainder == 0
  end

  # solution from bezout's identity, if it exists
  def base_solution
    @base_solution ||= bezout(@a, @b).map { |z| z * @multiplier } if solvable?
  end

  # solutions parametrized by an integer k
  def solution(k)
    if solvable?
      x, y = base_solution
      [x + @delta_x * k, y + @delta_y * k]
    end
  end
end

class TestLinearEquationSolver < Test::Unit::TestCase
  def test_solvable_equation
    a, b, c = 12, 15, 99
    solver = LinearEquationSolver.new(a, b, c)

    # solvable since gcd(12, 15) == 3 && 99 % 3 == 0
    assert solver.solvable?

    x, y = solver.base_solution
    assert_equal c, a*x + b*y

    (-10..10).each do |k|
      x, y = solver.solution(k)
      assert_equal c, a*x + b*y
    end
  end

  def test_unsolvable_equation
    a, b, c = 12, 15, 100
    solver = LinearEquationSolver.new(a, b, c)

    # not solvable since gcd(a, b) == 3 && 100 % 3 == 1
    assert !solver.solvable?

    assert_nil solver.base_solution
    (-10..10).each { |k| assert_nil solver.solution(k) }
  end
end

class LinearEquationSolverWithBounds < LinearEquationSolver
  def first_solution
    if @k_lower
      solution(@k_lower)
    end
  end

  def last_solution
    if @k_upper
      solution(@k_upper)
    end
  end

  def all_solutions
    @all_solutions ||= if @k_lower && @k_upper
      (@k_lower..@k_upper).map { |k| solution(k) }
    elsif @k_lower
      Enumerator.new do |yielder|
        offset = 0
        loop do
          yielder.yield solution(@k_upper + offset)
          offset += 1
        end
      end
    elsif @k_upper
      Enumerator.new do |yielder|
        offset = 0
        loop do
          yielder.yield solution(@k_upper - offset)
          offset += 1
        end
      end
    end
  end

  def set_bounds!(bounds)
    @x_lower = bounds.dig(:x, :lower)
    @x_upper = bounds.dig(:x, :upper)
    @y_lower = bounds.dig(:y, :lower)
    @y_upper = bounds.dig(:y, :upper)

    process_bounds!
    self
  end

  def k_value_from_x(value)
    Rational((value - base_solution.first) * @d, @b)
  end

  def k_value_from_y(value)
    Rational((value - base_solution.last) * @d, -@a)
  end

  def process_bounds!
    if solvable?
      if @x_lower
        if @b >= 0
          @k_lower = [@k_lower, k_value_from_x(@x_lower).ceil].compact.max
        else
          @k_upper = [@k_upper, k_value_from_x(@x_lower).floor].compact.min
        end
      end

      if @x_upper
        if @b >= 0
          @k_upper = [@k_upper, k_value_from_x(@x_upper).floor].compact.min
        else
          @k_lower = [@k_lower, k_value_from_x(@x_upper).ceil].compact.max
        end
      end

      if @y_lower
        if @a < 0
          @k_lower = [@k_lower, k_value_from_y(@y_lower).ceil].compact.max
        else
          @k_upper = [@k_upper, k_value_from_y(@y_lower).floor].compact.min
        end
      end

      if @y_upper
        if @a < 0
          @k_upper = [@k_upper, k_value_from_y(@y_upper).floor].compact.min
        else
          @k_lower = [@k_lower, k_value_from_y(@y_upper).ceil].compact.max
        end
      end
    end
  end
end
