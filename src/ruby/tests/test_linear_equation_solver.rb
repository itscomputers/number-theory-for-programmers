require_relative '../linear_equation_solver'

#-----------------------------
# test linear eqution solver: 7-32

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

