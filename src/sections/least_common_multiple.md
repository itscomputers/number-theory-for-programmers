# least common multiple

<span id="least-common-multiple" />

> A **common multiple** of two integers is an integer divisible by both
> integers.  The **least common multiple** of two integers is the smallest
> positive common multiple.

- The notation for the least common multiple of \\( a \\) and \\( b \\) is
  \\( \operatorname{lcm}(a, b) \\).

- By definition, the least common multiple of two integers is independent of
  the sign of the two integers --- the \\( \operatorname{lcm} \\) is the same
  if you replace \\( a \\) with \\( -a \\) or \\( b \\) with \\( -b \\).

- The definition of \\( \operatorname{lcm} \\) does not make sense if either
  \\( a \\) or \\( b \\) are is equal to \\( 0 \\).

- For the remainder of the section, we will assume integers to be nonzero.

The existence of a least common multiple stems from the fact that the absolute
value of the product \\( |ab| \\) is a positive common multiple of \\( a \\)
and \\( b \\).

## naive computation

The least common multiple can be computed naively by checking every
multiple of one of them up to their product to see if it is divisible
by the other.  For example, to compute \\( \operatorname{lcm}(154, 56) \\)

- start with \\( 154 \\) and keep adding \\( 154 \\) until it is divisible by
  \\( 56 \\)

- \\( 56 \\) does not divide \\( 154 \\), \\( 154(2) \\), or \\(154(3) \\)

- however, \\( 154(4) = 616 = 56(11) \\) is divisible by \\( 56 \\)

- the least common multiple is \\( \operatorname{lcm}(154, 56) = 616 \\)

<span id="naive-lcm-exercise" />

> **exercise.**
> Write a `naive_lcm` function that returns the least common multiple of two
> nonzero integer inputs.  It should only rely on divisibility checks.

<button class="fa fa-expand" onClick="showContent('naive_lcm')"></button>
<div id="naive_lcm" style="display: none;">

```ruby
{{#include ../ruby/division.rb:194:205}}
```

</div>

The time complexity of this algorithm, similar to the naive gcd algorithm,
grows linearly in the smaller of the two arguments.

## a property of the lcm

<span id="lcm-divides-common-multiples" />

> **proposition 7.**
> Every common multiple of two integers is a multiple of their least common
> multiple.

> *proof:*
> Let \\( k \\) be a common multiple of \\( a \\) and \\( b \\) and let \\( m \\)
> be their least common multiple.  Dividing \\( k \\) by \\( m \\) yields
> \\( k = mq + r \\), where \\( 0 \le r < m \\).  Since \\( r = k - mq \\) is a
> linear combination of \\( k \\) and \\( m \\), then \\( r \\) must be
> divisible by both \\( a \\) and \\( b \\), ie, \\( r \\) must be a common
> multiple of \\( a \\) and \\( b \\).  If \\( r \\) were nonzero, then it
> would be a smaller positive common multiple than the least common multiple, a
> contradiction.  Therefore, \\( r = 0 \\) and \\( m \mid k \\).

## relation to greatest common divisor

In order to compute the least common multiple efficiently, we need to prove an
identity involving the greatest common divisor.

<span id="least-common-multiple" />

> **proposition 8.**
> If \\( a \\) and \\( b \\) are nonzero integers, then
> \\( \gcd(a, b) \cdot \operatorname{lcm}(a, b) = \vert ab \vert \\).

> *proof:*
> For simplicity, we may assume that \\( a \\) and \\( b \\) are positive,
> since both the gcd and the lcm are independent of sign.  Define
> \\( d = \gcd(a, b) \\) and \\( m = \operatorname{lcm}(a, b) \\). The goal
> is to prove that \\( md = ab \\).
>
> Since \\( d \\) is a common divisor of \\( a, b\\), the integer \\( ab/d \\)
> can be expressed as \\( (a/d) \cdot b \\) or as \\( a \cdot (b/d) \\).  This
> implies that \\( ab/d \\) must be a common multiple of \\( a \\) and
> \\( b \\).  By [proposition 7](#lcm-divides-common-multiples),
> \\( ab/d \\) must be a multiple of \\( m \\), hence
> \\[ ab/d = mk \quad\implies\quad ab = mdk \quad\implies\quad md \mid ab. \\]
>
> Next, using Bezout's identity, there exist integers \\( x, y \\) such that
> \\( d = ax + by \\).  Multiplying both sides by \\( m \\) yields
> \\[ md = amx + bmy. \\]
> Since \\( b \mid m \\), it follows that \\( ab \mid am \\), so it divides the
> first term.  Since \\( a \mid m \\), it follows that \\( ab \mid bm \\), so
> it also divides the second term.  Therefore, \\( ab \\) divides the whole
> expression, which implies that \\( ab \mid md \\).
>
> Since each of \\( md \\) and \\( ab \\) is positive and divides the other,
> they must be equal.

## in code

<span id="lcm-exercise" />

> **exercise.**
> Write an `lcm` function that returns the least common multiple of two
> nonzero integer inputs.  It should use the `gcd` function and
> [proposition 8](#least-common-multiple).

For testing, we can compare the result to the `naive_lcm` result.  Be careful
to limit this type of test to just a few *positive* values since the naive
function is slow and restricted.  For more general test cases, we'll use the
proposition, even though we also rely on the proposition for the
implementation.

```ruby
{{#include ../ruby/division.rb:217:239}}
```

<button class="fa fa-expand" onClick="showContent('lcm')"></button>
<div id="lcm" style="display: none;">

```ruby
{{#include ../ruby/division.rb:210:214}}
```

</div>


