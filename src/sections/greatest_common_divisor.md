# greatest common divisor

> A **common divisor** of two integers \\( a \\) and \\( b \\) is an integer
> \\( d \\) such that \\( d \mid a \\) and \\( d \mid b. \\)  The **greatest
> common divisor** of \\( a \\) and \\( b \\) is their largest positive common
> divisor.

- The notation for the greatest common divisor of \\( a \\) and \\( b \\) is
  \\( \gcd(a, b) \\).

- By definition, the greatest common divisor of two integers is independent of
  the sign of the two integers --- the gcd is the same if you replace
  \\( a \\) with \\( -a \\) or \\( b \\) with \\( -b \\).

- The definition of gcd does not make sense if \\( a \\) and \\( b \\) are both
  equal to \\( 0 \\).  The assumption for the rest of the section is that at
  least one of them is nonzero.

The existence of a greatest common divisor stems from the following fact: every
pair of integers has 1 as a positive common divisor, and can only have finitely
many positive common divisors since any positive divisor of an integer is less
than or equal to its absolute value.

## naive computation

The greatest common divisor can be computed naively by finding the positive
divisors of each number and taking the intersection of the two sets.  For
example, to compute \\( \gcd(322, 70) \\)

- the positive divisors of \\( 322 \\) are
\\( \\{ 1, 2, 7, 14, 23, 46, 161, 322 \\} \\)

- the positive divisors of \\( 70 \\) are
\\( \\{ 1, 2, 5, 7, 10, 14, 35, 70 \\} \\)

- the positive common divisors of \\( 322 \\) and \\( 70 \\) are
\\( \\{ 1, 2, 7, 14 \\} \\)

- therefore, the greatest common divisor is \\( \gcd(322, 70) = 14 \\)

<span id="naive-gcd-exercise" />

> **exercise.**
> Write a `naive_gcd` function that returns the greatest common divisor of two
> integer inputs.  It should only rely on divisibility checks.

<button class="fa fa-expand" onClick="showContent('naive_gcd')"></button>
<div id="naive_gcd" style="display: none;">

```ruby
{{#include ../ruby/division.rb:66:76}}
```

</div>

## Euclidean algorithm

This naive gcd algorithm is slow, growing linearly in the size of the smaller
of the two integers.  The next proposition is instrumental in developing a more
efficient algorithm to compute the gcd.

<span id="division-algorithm-and-gcd" />

> **proposition 4.**
> If \\( a = bq + r \\), then \\( \gcd(a, b) = \gcd(b, r) \\).

> *proof:*
> Since \\( a = bq + r \\) is a linear combination of \\( b \\) and \\( r \\),
> any common divisor of \\( b \\) and \\( r \\) must also be a divisor of
> \\( a \\).
>
> Additionally, since \\( r = a - bq \\) is a linear combination of \\( a \\)
> and \\( b \\), any common divisor of \\( a \\) and \\( b \\) must also be a
> divisor of \\( r \\).
>
> Taken together, the set of common divisors of \\( a, b \\) must be equal
> to the set of common divisors of \\( b, r \\).  Therefore, \\( \gcd(a, b) \\)
> must be equal to \\( \gcd(b, r) \\).

This proposition combined with the division algorithm gives an efficient method
for computing the greatest common divisor.  Each time we use the division
algorithm, this proposition will give a smaller pair of numbers for computing
the greatest common divisor, since the division algorithm guarantees that the
remainder is smaller than the divisor in absolute value.

The **Euclidean algorithm** is repeated application of the division algorithm;
at each stage, we replace \\( a, b \\) with \\( b, r \\) until we reach a
remainder of \\( 0 \\).  At that point the gcd is trivial to compute.

As an example, we will calculate \\( \gcd(322, 70) \\) again, this time using the
Euclidean algorithm.  The left side of the table has each of the division
algorithm steps.  The right side has the greatest common divisor simplification
resulting from the division algorithm.

|    division w/ remainder | simplifed gcd          |
|-------------------------:|:-----------------------|
|                          | \\( \gcd(322, 70) \\)  |
| \\( 322 = 70(4) + 42 \\) | \\( = \gcd(70, 42) \\) |
|  \\( 70 = 42(1) + 28 \\) | \\( = \gcd(42, 28) \\) |
|  \\( 42 = 28(1) + 14 \\) | \\( = \gcd(28, 14) \\) |
|  \\( 28 = 14(2) +  0 \\) | \\( = \gcd(14, 0) \\)  |
|                          | \\( = 14 \\)           |

In the Euclidean algorithm, the last nonzero remainder is the gcd of the
original two integers.  Of extreme importance is the fact that the gcd is
computed without explicitly finding **any** of the divisors.

<span id="euclidean-algorithm-exercise" />

> **exercise.**
> Write a `euclidean_algorithm` function that prints the division algorithm
> result from each step.

Running the following code should produce the output below.

```ruby
{{#include ../ruby/division.rb:89}}
```

```
239847 == 95832 * 2 + 48183
95832 == 48183 * 1 + 47649
48183 == 47649 * 1 + 534
47649 == 534 * 89 + 123
534 == 123 * 4 + 42
123 == 42 * 2 + 39
42 == 39 * 1 + 3
39 == 3 * 13 + 0
```

<button class="fa fa-expand" onClick="showContent('euclidean_algorithm')"></button>
<div id="euclidean_algorithm" style="display: none;">

```ruby
{{#include ../ruby/division.rb:81:87}}
```

</div>

## computation of gcd

As mentioned, the Euclidean algorithm gives an algorithm to compute the
greatest common divisor.  One formulation of this algorithm is the following:

<span id="euclidean-algorithm" />

> To compute \\( \gcd(a, b) \\)
> 1. If \\( b = 0, \\) return \\( \vert a \vert \\).
>
> 2. If \\( b \ne 0 \\), compute \\( a = bq + r \\) and return to step 1,
>    replacing the pair \\( (a, b) \\) with \\( (b, r) \\).

This gcd algorithm terminates after finitely many steps: since the
remainders form a decreasing sequence of positive integers, there
can only be finitely many of them.

As mentioned before, in some programming languages, the modulus operator may
return a negative remainder when dealing with negative values.  However, the
result of `a % b` is still smaller than \\( b \\) in absolute value, so
repeated applications of the modulus operator will also terminate after
finitely many steps.  Since the proposition above applies regardless of whether
\\( a = bq + r \\) comes from the division algorithm, the greatest common
divisor algorithm may be implemented using **only** the modulus operator.

For example, here is the same table as above, but instead of performing the
whole division algorithm at each stage, we use only the modulus operator.

| modulus operator | simplified gcd         |
|-----------------:|:-----------------------|
|                  | \\( \gcd(322, 70) \\)  |
| `322 % 70 ~> 42` | \\( = \gcd(70, 42) \\) |
|  `70 % 42 ~> 28` | \\( = \gcd(42, 28) \\) |
|  `42 % 28 ~> 14` | \\( = \gcd(28, 14) \\) |
|   `28 % 14 ~> 0` | \\( = \gcd(14, 0) \\)  |
|                  | \\( = 14 \\)           |

Here is the same algorithm, rephrased.

> To compute `gcd(a, b)`
> 1. If `b == 0`  return `abs(a)`.
>
> 2. If `b != 0`, replace `(a, b)` with `(b, a % b)` and return to step 1.

<span id="gcd-exercise" />

## in code

> **exercise.**
> Write a `gcd` function that uses the modulus operator: it should take two
> integer inputs and produce their greatest common divisor.  Remember that
> \\( \gcd(0, 0) \\) is undefined.

For testing, we will verify some of the essential properties of the greatest
common divisor as well as some specific examples.  The last property in the
test is proved in [proposition 5](#gcd-property) below.  In my ruby
implementation tested below, `nil` is returned when the inputs are both zero.
You may opt to do some error handling instead a null return value.

```ruby
{{#include ../ruby/division.rb:104:141}}
```

<button class="fa fa-expand" onClick="showContent('gcd')"></button>
<div id="gcd" style="display: none;">

```ruby
{{#include ../ruby/division.rb:94:102}}
```

</div>

This new algorithm to find the greatest common divisor is extremely fast.  It
can be proved that it grows logarithmically in the size of the smaller of the
two inputs, which is a vast improvement over the linear growth of the naive gcd
function we wrote.

## a property of the gcd

<span id="gcd-property" />

> **proposition 5.**
> If \\( d = \gcd(a, b) \\), then \\( \gcd({a \over d}, {b \over d} ) = 1. \\)

> *proof:*
> Let \\( k = \gcd({a \over d}, {b \over d}) \\).  Then
> \\( {a \over d} = km \\) and \\( {b \over d} = kn \\).  This implies that
> \\( a = kdm \\) and \\( b = kdn \\), so \\( kd \\) is a common divisor of
> \\( a \\) and \\( b \\).  If \\( k \\) were larger than \\( 1 \\), then
> \\( kd \\) would be a larger common divisor than the greatest common divisor
> \\( d \\), a contradiction.

<span id="exercises" />

## exercises

1. Explain why \\( \gcd(0, 0) \\) is undefined.

2. If \\( a \\) is nonzero, prove that \\( \gcd(a, 0) = \vert a \vert \\).

3. If \\( b \mid a \\), prove that \\( \gcd(a, b) = \vert b \vert \\).

4. Prove that every common divisor of two integers divides their greatest
   common divisor.  (Hint: look over the proof of
   [proposition 4](#division-algorithm-and-gcd).)

5. Benchmark `gcd` vs `naive_gcd` to convince yourself of the stated time
   complexity.

<button onClick="showContent('solutions')">show solutions</button>
<div id="solutions" style="display: none;">

1. Since every integer divides \\( 0 \\), then every integer is a common
   divisor of \\( 0 \\) and \\( 0 \\), so there is no *greatest* common
   divisor.

2. Again, since every integer divides \\( 0 \\), the set of common divisors of
   \\( 0 \\) and an integer \\( a \\) is equal to the set of divisors of
   \\( a \\).  The largest divisor of \\( a \\) is its absolute value, so that
   must be the gcd.

3. The greatest common divisor is less than or equal to the absolute value of
   the smaller of the two integers.  If \\( b \\) divides \\( a \\), then
   \\( b \\) must be smaller in absolute value.  Therefore, the gcd is at most
   \\( \vert b \vert \\).  In addition, since \\( b \\) divides \\( a \\), we
   know that \\( \vert b \vert \\) divides \\( a \\), which proves that
   \\( \gcd(a, b) = \vert b \vert \\).

4. In the course of proving [proposition 4](#division-algorithm-and-gcd), we
   noted that the set of common divisors of \\( a, b \\) is equal to the set of
   common divisors of \\( b, r \\) if \\( a = qb + r \\).  Repeating the
   division algorithm as we do in the Euclidean algorithm, we eventually find
   that the common divisors of two integers is equal to the set of divisors of
   their gcd and zero.  This proves that each common divisor divides the
   greatest common divisor.

</div>
