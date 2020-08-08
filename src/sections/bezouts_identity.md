# bezout's identity

> **proposition 6 (Bezout's identity).**
> The greatest common divisor can always be expressed as a linear combination
> of the two integers.  In other words, given two integers \\( a \\) and
> \\( b \\), there exist integers \\( x \\) and \\( y \\) such that
> \\( ax + by = \gcd(a, b) \\).

The proof of this is constructive and most easily understood through a few
examples.

## example 1

For example, if \\( a = 322 \\) and \\( b = 70 \\), Bezout's identity implies
that \\( 322x + 70y = 14 \\) for some integers \\( x \\) and \\( y \\).  Such
integers might be found by brute force.  In this case, a brute force search
might arrive at the solution \\( (x, y) = (-2, 9) \\).  However, the Euclidean
algorithm provides an efficient way to find a solution.

The first division yields \\( 322 = 70(4) + 42 \\) with a quotient of
\\( q_0 = 4 \\) and a remainder of \\( r_0 = 42 \\).  Solving for \\( r_0 \\)
gives \\( 42 = 322 - 70(4) \\).  In particular, we have shown that the
remainder \\( r_0 \\) can be expressed as a linear combination of \\( 322 \\)
and \\( 70 \\), namely \\( r_0 = 322(1) + 70(-4) \\).

The second division yields \\( 70 = 42(1) + 28 \\) with a quotient of
\\( q_1 = 1 \\) and a remainder of \\( r_1 = 28 \\).  Solving for
\\( r_1 \\) gives \\( 28 = 70 - 42(1) \\).  The linear combination for
\\( r_0 = 42 \\) may be substituted here and simplified to
\\( 28 = -322 + 70(5) \\). Therefore, the remainder
\\( r_1 = 322(-1) + 70(5) \\) is also a linear combination of the original two
integers.

The third division gives \\( 42 = 28(1) + 14 \\) with a quotient of
\\( q_2 = 1 \\) and a remainder of \\( r_2 = 28 \\).  The linear combinations
for \\( r_0 = 42 \\) and \\( r_1 = 28 \\) may be substituted into this
expression.  Then solving for the new remainder, it will simplify to
\\( 14 = 322(2) + 70(-9) \\), which is the solution to Bezout's identity
that was listed above.

These computations are summarized in the table below. In each of the first
three rows, the last column is how to express each remainder \\( r \\) as a
linear combination of the original \\( a = 322 \\) and \\( b = 70 \\), namely,
\\( r = 322x + 70y \\).  The last row verifies that the algorithm has
terminated, ie, that the gcd of \\( 322 \\) and \\( 70 \\) is the
second-to-last remainder \\( 14 \\).

|  \\( a' \\)  | \\( b' \\)  |   \\( r \\)  | \\( q \\)  |  \\( (x, y) \\)  |
|-------------:|------------:|-------------:|-----------:|:-----------------|
| \\( 322 \\)  | \\( 70 \\)  |  \\( 42 \\)  | \\( 4 \\)  | \\( (1, -4) \\)  |
|  \\( 70 \\)  | \\( 42 \\)  |  \\( 28 \\)  | \\( 1 \\)  | \\( (-1, 5) \\)  |
|  \\( 42 \\)  | \\( 28 \\)  |  \\( 14 \\)  | \\( 1 \\)  | \\( (2, -9) \\)  |
|  \\( 28 \\)  | \\( 14 \\)  |   \\( 0 \\)  | \\( 2 \\)  |                  |

We would like a programatic way to compute the \\( (x, y) \\) pairs as we go.
Suppose that on some row we have \\( a' = b'q + r \\) and that we have already
calculated that \\( a' = 322 x_0 + 70 y_0 \\) and
\\( b' = 322 x_1 + 70 y_1 \\).  We can substitute these expressions into the
division algorithm equation to get
\\[ 322 x_0 + 70 y_0 = (322 x_1 + 70 y_1)q + r. \\]
Solving for \\( r \\) and rearranging, we get
\\[ r = 322 (x_0 - x_1 q) + 70(y_0 - y_1 q). \\]

This is great news, because we can compute the the next \\( (x, y) \\)
pair from the previous two pairs.  The recursive relation for both \\( x \\)
and \\( y \\) can be expressed as
\\[ u_2 = u_0 - u_1 \cdot q. \\]
In other words, the `next_value = previous_value - current_value * quotient`.

To see this in action, we observe first that \\( a = a(1) + b(0) \\) and
\\( b = a(0) + b(1) \\), so the initial values for the \\( (x, y) \\) pairs
are \\( (1, 0) \\) and \\( (0, 1) \\).

The first quotient is \\( q = 4 \\), so the first \\( (x, y) \\) pair is
\\[ (1, 0) - (0, 1) \cdot 4 = (1 - 0, 0 - 4) = (1, -4). \\]
(Note that we used vector addition and scalar multiplication to express this
succinctly.)  The second quotient is \\( q = 1 \\), so the second pair is
\\[ (0, 1) - (1, -4) \cdot 1 = (0 - 1, 1 + 4) = (-1, 5). \\]
The third quotient is \\( q = 1 \\), so the third pair is
\\[ (1, -4) - (-1, 5) \cdot 1 = (1 + 1, -4 - 5) = (2, -9). \\]
Since the following remainder is \\( 0 \\), the algorithm terminates.

## example 2

Here is another example to illustrate this process.  Suppose we want to
find a solution to \\( 5831 x + 482 y = \gcd(5831, 482) \\).  We seed our table
with the initial \\( (x, y) \\) pairs and with \\( a \\) and \\( b \\) as the
first "remainders".

|   \\( a' \\) |  \\( b' \\) |    \\( r \\) | \\( q \\) | \\( (x, y) \\) |
|-------------:|------------:|-------------:|----------:|:---------------|
|              |             | \\( 5831 \\) |           | \\( (1, 0) \\) |
|              |             |  \\( 482 \\) |           | \\( (0, 1) \\) |

The division of \\( 5381 \\) by \\( 482 \\) yields \\( 5831 = 482(12) + 47 \\).
Since the quotient is \\( q = 12 \\), we calculate the next \\( (x, y) \\) pair
to be
\\[ (1, 0) - (0, 1) \cdot 12 = (1 - 0, 0 - 12) = (1, -12) \\]
and we fill in the new row on the table.

|   \\( a' \\) |  \\( b' \\) |    \\( r \\) |  \\( q \\) | \\( (x, y) \\) |
|-------------:|------------:|-------------:|-----------:|:---------------|
|              |             | \\( 5831 \\) |            | \\( (1, 0) \\) |
|              |             |  \\( 482 \\) |            | \\( (0, 1) \\) |
| \\( 5831 \\) | \\( 482 \\) |    \\(47 \\) | \\( 12 \\) | \\( (1, -12) \\) |

The division of \\( 482 \\) by \\( 47 \\) yields \\( 482 = 47(10) + 12 \\).
Since the quotient is \\( q = 10 \\), we calculate the next \\( (x, y) \\) pair
to be
\\[ (0, 1) - (1, -12) \cdot 10 = (0 - 10, 1 + 120) = (-10, 121) \\]
and we fill in the new row on the table.

|   \\( a' \\) |  \\( b' \\) |    \\( r \\) |  \\( q \\) | \\( (x, y) \\)     |
|-------------:|------------:|-------------:|-----------:|:-------------------|
|              |             | \\( 5831 \\) |            | \\( (1, 0) \\)     |
|              |             |  \\( 482 \\) |            | \\( (0, 1) \\)     |
| \\( 5831 \\) | \\( 482 \\) |    \\(47 \\) | \\( 12 \\) | \\( (1, -12) \\)   |
|  \\( 482 \\) |  \\( 47 \\) |    \\(12 \\) | \\( 10 \\) | \\( (-10, 121) \\) |

The division of \\( 47 \\) by \\( 12 \\) yields \\( 47 = 12(3) + 11 \\).  With
a quotient of \\( q = 3 \\), the next \\( (x, y) \\) pair is
\\[ (1, -12) - (-10, 121) \cdot 3 = (1 + 30, -12 - 363) = (31, -375) \\]
and we fill in the new row on the table.

|   \\( a' \\) |  \\( b' \\) |    \\( r \\) |  \\( q \\) | \\( (x, y) \\)     |
|-------------:|------------:|-------------:|-----------:|:-------------------|
|              |             | \\( 5831 \\) |            | \\( (1, 0) \\)     |
|              |             |  \\( 482 \\) |            | \\( (0, 1) \\)     |
| \\( 5831 \\) | \\( 482 \\) |    \\(47 \\) | \\( 12 \\) | \\( (1, -12) \\)   |
|  \\( 482 \\) |  \\( 47 \\) |    \\(12 \\) | \\( 10 \\) | \\( (-10, 121) \\) |
|   \\( 47 \\) |  \\( 12 \\) |    \\(11 \\) |  \\( 3 \\) | \\( (31, -375) \\) |

The division of \\( 12 \\) by \\( 11 \\) yields \\( 12 = 11(1) + 1 \\).  With a
quotient of \\( q = 1 \\), the next pair is
\\[ (-10, 121) - (31, -375) \cdot 1 = (-10 - 31, 121 + 375) = (-41, 496) \\]
and we fill in the new row.

|   \\( a' \\) |  \\( b' \\) |    \\( r \\) |  \\( q \\) | \\( (x, y) \\)     |
|-------------:|------------:|-------------:|-----------:|:-------------------|
|              |             | \\( 5831 \\) |            | \\( (1, 0) \\)     |
|              |             |  \\( 482 \\) |            | \\( (0, 1) \\)     |
| \\( 5831 \\) | \\( 482 \\) |    \\(47 \\) | \\( 12 \\) | \\( (1, -12) \\)   |
|  \\( 482 \\) |  \\( 47 \\) |    \\(12 \\) | \\( 10 \\) | \\( (-10, 121) \\) |
|   \\( 47 \\) |  \\( 12 \\) |    \\(11 \\) |  \\( 3 \\) | \\( (31, -375) \\) |
|   \\( 12 \\) |  \\( 11 \\) |     \\(1 \\) |  \\( 1 \\) | \\( (-41, 496) \\) |

The final division of \\( 11 \\) by \\( 1 \\) yields \\( 11 = 1(11) + 0 \\).
With a remainder of \\( 0 \\), the algorithm has terminated.  The greatest
common divisor is \\( \gcd(5831, 482) = 1 \\) and \\( (-41, 496) \\) is a
solution to \\( 5831 x + 482 y = 1 \\).

## in code

The examples above can be generalized into a constructive proof of Bezout's
identity -- the proof is an algorithm to produce a solution.

<span id="bezout-algorithm" />

> **Bezout algorithm for positive integers.**
> Given *positive* integers `a` and `b`, we want to find integers `x` and `y`
> such that `a * x + b * y == gcd(a, b)`.  Initially set `prev = [1, 0]` and
> `curr = [0, 1]`.
> 1. If `b == 0`, return `prev`.
> 2. Calculate `q, r = div_rem(a, b)`.
> 3. Calculate `x = prev[0] - curr[0] * q` and `y = prev[1] - curr[1] * q`.
> 4. Replace `a, b` with `b, r`.
> 5. Replace `prev, curr` with `curr, [x, y]`.
> 6. Return to Step 1.

The algorithm needs to be adjusted slightly for zero or negative values.  Run
the algorithm described for various combinations of positive, negative, and
zero values, checking whether each resulting pair `x, y` actually satisfies
`a * x + b * y == gcd(a, b)`.

While exploring zero/negative values, there are 3 cases to consider:
1. when the algorithm returns immediately, ie, when the original `b` is zero.
2. when the algorithm returns after one iteration, ie, when the first remainder
   `r` is zero.
3. when the algorithm returns after two or more iterations.

We seeded the algorithm initially with `prev = [1, 0]` and `curr = [0, 1]`.
We did this in order to express `a` and `b` in terms of themselves, ie,
`a == 1 * a + 0 * b` and `b == 0 * a + 1 * b`.  With two or more iterations,
the division algorithm guarantees that the remainder is positive, so the
calculated pair at that point gives a positive number `a * x + b * y`.
However, if the algorithm terminates during the first or second iteration, we
would return either `[1, 0]` or `[0, 1]`, in which case we may end up with
`a * x + b * y` as a negative value, which would be incorrect since the
greatest common divisor is always positive.

To account for this, we may need to negate the values of `prev` in Step 1
before returning.  Consider these two examples.

1. Let `a = -10` and `b = 0`.  Since `b == 0`, we return the original
   `prev = [1, 0]` immediately.  Notice that `1 * -10 + 0 * 0 == -10` while
   `gcd(-10, 0) == 10`.  In this case, we need to return the original `prev`
   but with negated values, ie, `[-1, 0]`.

2. Let `a = 10` and `b = -5`.  Since `b != 0`, we calculate `q = -2` and
   `r = 0`.  When we return to Step 1, we have `new_b = r == 0`, so we return
   `new_prev = curr == [0, 1]`.  Notice that `0 * 10 + 1 * -5 = -5` while
   `gcd(10, -5) == 5`.  In this case, we need to return the `new_prev` but with
   negated values, ie, `[0, -1]`.

The conclusion is that Step 1 requires the following adjustment:

> 1. If `b == 0`, return `prev` if `a > 0`, otherwise return `prev` with
>    negated values.

<span id="bezout-exercise" />

> **exercise.**
> Write a `bezout` function that takes integer inputs `(a, b)` and
> produces integers `(x, y)` such that `a * x + b * y = gcd(a, b)`.

Testing this function is very simple: regardless of the inputs, Bezout's
identity must be satisfied.  Make sure you include test inputs for the special
cases discussed above.

```ruby
{{#include ../ruby/division.rb:179:188}}
```

<button class="fa fa-expand" onClick="showContent('bezout')"></button>
<div id="bezout" style="display: none;">

```ruby
{{#include ../ruby/division.rb:162:176}}
```

</div>

## applications of bezout's identity

Bezout's identity is a powerful tool since it gives a relationship between
integers to their greatest common divisor.  Some proofs can be vastly
simplified by leveraging this new capability.  Here are a few propositions
that can be proved using Bezout's identity.

> **proposition 9.**
> The greatest common divisor of two integers is divisible by any common
> divisor.

> *proof*:
> Let \\( k \\) be a common divisor of \\( a, b \\) and let \\( d \\) be their
> greatest common divisor.  Bezout's lemma allows us to write \\( ax + by = d \\)
> for some integers \\( x, y \\).  Since \\( k \\) divides both \\( a \\) and
> \\( b \\), it divides the linear combination \\( ax + by \\), which is equal
> to \\( d \\).

<span id="divides-product-but-prime-to-first" />

> **proposition 10.**
> If an integer \\( c \\) divides a product \\( ab \\) and
> \\( \gcd(a, c) = 1 \\), then \\( c \\) divides \\( b \\).

> *proof:*
> Since \\( \gcd(a, c) = 1 \\), then we can write \\( ax + cy = 1 \\) for some
> integers \\( x, y \\).  Multiplying both sides by \\( b \\), we get
> \\[ abx + bcy = b. \\]
> The first term is divisible by \\( c \\), since \\( c \\) is assumed to
> divide the product \\( ab \\).  The second term is divisible by \\( c \\)
> since \\( c \\) occurs in that term.  Therefore, their sum is divisible by
> \\( c \\), which proves that \\( b \\) is divisible by
> \\( c \\).

