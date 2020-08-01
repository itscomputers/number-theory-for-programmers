# division with remainder

In the [divides function](./divisibility.md#divides-exercise) from the last
section, we employed a `while` loop.  The eventual termination of the loop
depends on the following principle.

> **Archimedes' principle.**
> For an integer \\( a \\) and a nonzero integer \\( b \\), there exists a
> multiple of \\( b \\) which is greater than or equal to \\( a \\).

This principle is equivalent to the **division algorithm**, which we will
prove.

<span id="division-algorithm" />

> **proposition 2 (division algorithm).**
> For an integer \\( a \\) and a nonzero integer \\( b \\), there are unique
> integers \\( q \\) and \\( r \\) such that
> \\( a = bq + r \\) and \\( 0 \le r < |b|. \\)

Terminology:
- \\( a \\) is called the **dividend**.
- \\( b \\) is called the **divisor**.
- \\( q \\) is called the **quotient**.
- \\( r \\) is called the **remainder**.

Before proving the division algorithm, here are a few examples.
- Dividing \\( 71 \\) by \\( 20 \\) gives \\( 71 = 20(3) + 11 \\)
- Dividing \\( 71 \\) by \\( -20 \\) gives \\( 71 = -20(-3) + 11  \\)
- Dividing \\( -71 \\) by \\( 20 \\) gives \\( -71 = 20(-4) + 9 \\)
- Dividing \\( -71 \\) by \\( -20 \\) gives \\( -71 = -20(4) + 9 \\)

> *proof of division algorithm:*
> If \\( a \ge 0 \\), consider the set \\( S \\), consisting of integers of
> the form \\( a - bn \\) where \\( n \\) is an integer, ie,
> \\[ S = \{ a - bn: n \in \mathbf{Z} \}. \\]
> The intersection of \\( S \\) the with nonnegative integers is non-empty,
> since \\( a \\) itself is nonnegative. By the well-ordering principle, there
> must be a unique smallest nonnegative element of \\( S \\), say
> \\( r = a - bq \\).  Since \\( r - |b| \\) is a smaller element of \\( S \\),
> it must be negative, hence \\( r < |b| \\).
>
> If \\( a < 0 \\), then \\( -a \\) is positive, which was proven above to be
> expressable as \\( -a = bQ + R. \\)  If \\( R = 0 \\), set \\( q = -Q \\) and
> \\( r = 0. \\)  Otherwise, set \\( r = -R + |b| \\) and
> \\( q = -Q - |b| / b. \\)  In either case, we have
> \\[ a = -bQ - R = bq + r \\] with \\( 0 \le r < |b|. \\)

## in code

In most programming languages, the implementation of a division and remainder
(modulus) operator likely will not match the specification given by the
division algorithm: when the dividend or divisor is negative, it may result in
a negative remainder.

In ruby, for example, integer division is floor division, so the quotient
`a / b` is computed by rounding down the rational number \\( a / b \\).
Therefore, the sign of the remainder `a % b` is the same as the sign of the
divisor `b`.

|   `a` |   `b` | `a / b` | `a % b` |
|------:|------:|--------:|--------:|
|  `71` |  `20` |     `3` |    `11` |
|  `71` | `-20` |    `-4` |    `-9` |
| `-71` |  `20` |    `-4` |     `9` |
| `-71` | `-20` |     `3` |   `-11` |

In rust, on the other hand, integer division is truncation, so the quotient
`a / b` is computed by rounding the rational number \\( a / b \\) toward zero.
Therefore, the sign of the remainder `a % b` is the same as the sign of the
dividend `a`.

|   `a` |   `b` | `a / b` | `a % b` |
|------:|------:|--------:|--------:|
|  `71` |  `20` |     `3` |    `11` |
|  `71` | `-20` |    `-3` |    `11` |
| `-71` |  `20` |    `-3` |   `-11` |
| `-71` | `-20` |     `3` |   `-11` |

<span id="division-algorithm-exercise" />

> **exercise**:
> Write a `div_rem` function that takes a dividend `a` and a nonzero divisor
> `b` as inputs, and outputs a quotient `q` and a remainder `r` satisifying
> the division algorithm.

The division algorithm itself gives the specifications to validate that
`div_rem` is implemented correctly.  Following is a test in ruby that asserts
the properties from the division algorithm for some test inputs.  Note that I
am specifically suppressing test inputs where the arguments could be zero since
`div_rem(a, b)` is undefined when `b == 0`.

```ruby
{{#include ../ruby/division.rb:74:82}}
```

Click the expand button to see an implementation of `div_rem` in ruby.

<button class="fa fa-expand" onClick="showContent('div_rem')"></button>
<div id="div_rem" style="display: none;">

```ruby
{{#include ../ruby/division.rb:65:71}}
```

</div>

## divisibility and remainders

The division algorithm is an extension of the idea of divisibility, as this
proposition makes clear.

> **proposition 3.**
> A nonzero integer \\( b \\) divides an integer \\( a \\) if and only if the
> division of \\( a \\) by \\( b \\) yields a remainder of \\( 0 \\).

> *proof:*
> If the division algorithm gives \\( a = bq + r \\) with \\( r = 0\\), then
> \\( a = bq \\), which implies the \\( b \mid a \\).
>
> Conversely, if \\( b \mid a \\), then \\( a = bn \\) for some \\( n \\).
> Since the division algorithm produces a unique quotient and remainder, it
> must be true that \\( q = n \\) and \\( r = 0 \\).

<span id="exercises" />

## exercises

Compute by hand the quotient and remainder when dividing:

1. \\( 345 \\) by \\( 14 \\)

2. \\( -872 \\) by \\( 77 \\)

3. \\( 7373 \\) by \\( -205 \\)

4. \\( -762 \\) by \\( -11 \\)

<button onClick="showContent('solutions')">show solutions</button>
<div id="solutions" style="display: none;">

1. \\( 345 = 14(24) + 9 \\)

2. \\( -872 = 77(-12) + 52 \\)

3. \\( 7373 = -205(-35) + 198 \\)

4. \\( -762 = -11(70) + 8 \\)

</div>
