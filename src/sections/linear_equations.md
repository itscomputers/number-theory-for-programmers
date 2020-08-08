# linear equations

In this section, we discuss finding integer solutions to integer linear
equations.  An integer linear equation in two variables \\( x, y \\) is of the
form
\\[ ax + by = c \\]
where \\( a, b, c \\) are given integers.  We are interested in finding, if possible,
integers \\( x, y \\) that satisfy the equation.

The linear equation \\( ax + by = c \\) defines a line in the plane.  As such,
there are infinitely many *real* solutions, for example
\\( (x, y) = (\frac{c}{a}, 0) \\).  It is not readily apparent under what
conditions there exist points on the line with integer coordinates.

## existence of a solution

<span id="linear-equation-solution-existence" />

> **proposition 11.**
> Given integers \\( a, b, c \\), there exist integers \\( x, y \\) such that
> \\( ax + by = c \\) if and only if \\( c \\) is divisible by
> \\( \gcd(a, b) \\).

> *proof:*
> Suppose that \\( ax + by = c \\) for some integers \\( x, y \\).  Since
> \\( c \\) is a linear combination of \\( a \\) and \\( b \\), then
> [proposition 1](divisibility.html#linear-combination) implies that
> \\( c \\) is divisible by any common divisor of \\( a, b \\).  In particular,
> \\( c \\) is divisible by their greatest common divisor.
>
> On the other hand, suppose that \\( c \\) is divisible by
> \\( d = \gcd(a, b) \\).  Then \\( c = k d \\) for some integer
> \\( k \\).  By [Bezout's identity](bezouts_identity.html), there exist
> integers \\( u, v \\) such that \\( au + bv = d \\).  Multiplying
> both sides by \\( k \\), we have
> \\[ a(ku) + b(kv) = k d = c, \\]
> hence \\( (x, y) = (ku, kv) \\) is an integer solution to
> \\( ax + by = c \\).

This is a constructive proof: if a solution exists, it gives a mechanism to
find a solution.

### example

Suppose we want to solve \\( 322 x + 70 y = 126 \\).
1. Compute `gcd(322, 70) ~> 14`.

2. Compute `div_rem(126, 14) ~> [9, 0]` and conclude that a solution exists
   since \\( 126 = 14 \cdot 9 \\).

3. Compute `bezout(322, 70) ~> [2, -9]` to get the equation
   \\( 322(2) + 70(-9) = 14 \\).

4. Scale this equation by a factor of \\( 9 \\) to get
   \\( 322(18) + 70(-81) = 126 \\).

Therefore, one solution is \\( (x, y) = (18, -81) \\).

## parametrization of solutions

<span id="linear-equation-solutions-parametrization">

> **proposition 12.**
> Given integers \\( a, b, c \\), if there exists an integer solution to the
> linear equation \\( ax + by = c \\), then there exist infinitely many
> solutions.  Moreover, the set of all solutions may be obtained from a single
> solution \\( (x_0, y_0) \\) by taking all pairs of the form
> \\[ x = x_0 + \tfrac{b}{d} k, \quad y = y_0 - \tfrac{a}{d} k \\]
> where \\( k \\) is any integer and \\( d = \gcd(a, b) \\).

Before giving a formal proof, let's talk about the intuition behind these
additional solutions.  As mentioned above, the equation \\( ax + by = c \\)
identifies a line in the plane.  Solving for \\( y \\), we get
\\[ y = -\tfrac{a}{b}x + c, \\]
so the slope of this line is the rational number \\( \tfrac{-a}{b} \\).  If
\\( d = \gcd(a, b) \\), then the reduced form of the slope is
\\( \tfrac{ -a/d }{ b/d } \\).  If there is an integer point
\\( (x_0, y_0) \\) on the line, then we can use this slope to find the "next"
integer point.  Since the slope is the change in \\( y \\) divided by the
change in \\( x \\), that means we can add \\( \tfrac{b}{d} \\) to the
\\( x \\)-value and subtract \\( \tfrac{a}{d} \\) from the \\( y \\)-value to
get the "next" integer point.  To get *all* integer points, we apply this same
process in both directions indefinitely.

### example

Continuing the example from above of \\( 322 x + 70 y = 126 \\), the
corresponding line in slope-intercept form is
\\[ y = -\tfrac{322}{70} x + \tfrac{126}{70} = -\tfrac{23}{5} x + \tfrac{9}{5}. \\]
We already found a base solution of \\( (18, -81) \\).  So, according to this
proposition, every solution is of the form
\\[ x = 18 + 5k, \quad y = -81 - 23k \\]
where \\( k \\) can be any integer.  For instance, the solutions closest
to the origin occur when \\( k = -3, -4 \\), ie, at
\\[ (3, -12) \quad \text{ and } \quad (-2, 11). \\]

<div class="chart-container" style="position: relative;">
  <canvas id="linear-graph"></canvas>
</div>

<script>
  const gridColor = "#444";
  const pointColor = "#aa5325";
  const label = "integer points";
  const labels = [-7, -2, 3, 8, 13, 18, 23];
  const data = labels.map(x => (-23 * x + 9) / 5);
  const yTicks = { beginAtZero: false, stepSize: 20, suggestedMin: -110, suggestedMax: 30 };
  const xTicks = { stepSize: 5 };
  const gridLines = { color: gridColor, zeroLineColor: gridColor };
  const datasetOptions = {
    borderColor: "#007999",
    pointBackgroundColor: pointColor,
    pointBorderColor: pointColor,
    fill: false
  };
  let ctx = document.getElementById("linear-graph");
  let linearGraph = new Chart(ctx, {
    type: 'line',
    data: {
      labels,
      datasets: [{ label, data, ...datasetOptions }],
    },
    options: {
      scales: {
        yAxes: [{ gridLines, ticks: yTicks }],
        xAxes: [{ gridLines, ticks: xTicks }],
      }
    },
  });
</script>

> *proof of proposition 12:*
> Supposing we have two solutions to \\( ax + by = c \\), say \\( (x_0, y_0) \\)
> and \\( (x_1, y_1) \\), then
> \\[ a x_1 + b y_1 = c = a x_0 + b y_0. \\]
> Moving the \\( x \\)'s and \\( y \\)'s to opposite sides, we get
> \\[ a (x_1 - x_0) = b (y_0 - y_1). \\]
> Both sides are divisible by \\( d = \gcd(a, b) \\), therefore
> \\[ \tfrac{a}{d} (x_1 - x_0) = \tfrac{b}{d} (y_0 - y_1) \\]
> is an integer equation.  This means that the integer \\( \tfrac{b}{d} \\)
> must divide the product \\( \tfrac{a}{d} (x_1 - x_0) \\).  By
> [proposition 5](greatest_common_divisor.html#gcd-property),
> we know that \\( \gcd(\tfrac{a}{d}, \tfrac{b}{d}) = 1 \\).  Therefore,
> [proposition 10](bezouts_identity.html#divides-product-but-prime-to-first)
> guarantees that the integer \\( \tfrac{b}{d} \\) must divide \\( x_1 - x_0 \\).  In
> other words, there is an integer \\( k \\) such that
> \\[
>     x_1 - x_0 = \tfrac{b}{d} k
>       \quad \implies \quad
>     x_1 = x_0 + \tfrac{b}{d} k.
> \\]
> Plugging the first version of this equation into the left-hand side above, we
> get
> \\[ \tfrac{a}{d} \cdot \tfrac{b}{d} k = \tfrac{b}{d} (y_0 - y_1) \\]
> which simplifies to
> \\[
>     \tfrac{a}{d} k = y_0 - y_1
>       \quad \implies \quad
>     y_1 = y_0 - \tfrac{a}{d} k.
> \\]
> This proves that any additional solution \\( (x_1, y_1) \\) is of the form
> prescribed by the proposition.
>
> To finish the proof, it remains to show that pairs of that form are always
> solutions.  Let \\( k \\) be any integer and define
> \\( x_1 = x_0 + \tfrac{b}{d} k \\) and \\( y_1 =  y_0 - \tfrac{a}{d} k \\).
> Then,
> \\[
>     a x_1 + b y_1
>       = a(x_0 + \tfrac{b}{d} k) + b(y_0 - \tfrac{a}{d} k)
>       = a x_0 + b y_0.
> \\]
> Therefore, if \\( (x_0, y_0) \\) is a solution, then so is \\( (x_1, y_1) \\).

## in code

<span id="linear-equation-exercise" />

> **exercise.**
> Write some code that takes integer inputs `(a, b, c)` and computes integer
> solutions `(x, y)` to `a * x + b * y = gcd(a, b)`.

I opted to write a `LinearEquationSolver` class in ruby.  Perhaps your solution
will have very different structure.  With the syntax I chose, the computations
from the examples could be accomplished as follows.

```ruby
solver = LinearEquationSolver.new(322, 70, 126)

solver.base_solution
# ~> [18, -81]

solver.solution(-3)
# ~> [3, -12]

solver.solution(-4)
# ~> [-2, 11]
```

I have two tests: one for when there are
solutions, and one for when there are no solutions.

```ruby
{{#include ../ruby/linear_equation_solver.rb:40:65}}
```

<button class="fa fa-expand" onClick="showContent('linear-equation-solver')"></button>
<div id="linear-equation-solver" style="display: none;">

```ruby
{{#include ../ruby/linear_equation_solver.rb:7:37}}
```

</div>
