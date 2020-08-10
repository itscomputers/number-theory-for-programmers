require_relative 'division'

#-----------------------------
# linear equation solver: 7-37

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

