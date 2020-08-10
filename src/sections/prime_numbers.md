# prime numbers

<span id="primality-definition" />

> An integer \\( n \ge 2 \\) is **prime** if its only positive divisors are
> \\( 1 \\) and \\( n \\) and **composite** otherwise.

* The positive integer \\( 1 \\) is considered neither prime nor composite.

* The divisors \\( 1 \\) and \\( n \\) are called the _trivial_ divisors of
  \\( n \\).  A _non-trivial_ divisor is a divisor strictly between \\( 1 \\)
  and \\( n \\).  So, an integer greater than 1 is prime if it has no
  non-trivial divisors and composite if it has a trivial divisor.

There are 25 primes up to 100, listed below.

```ruby
{{#include ../ruby/primality.rb:7:13}}
```

We will use this list to test the primality testing methods we write later on.

```ruby
{{#include ../ruby/primality.rb:26:32}}
```

## naive primality testing

<span id="naive-primality-v1" />

> **exercise.**
> Write an `is_prime_naive_v1?` function that takes an integer input and
> returns `true` if it is prime and `false` otherwise.  It should only use
> only the definition.

```ruby
{{#include ../ruby/primality.rb:34:36}}
```

<button class="fa fa-expand" onClick="showContent('is_prime_naive_v1')"></button>
<div id="is_prime_naive_v1" style="display: none;">

```ruby
{{#include ../ruby/primality.rb:15:18}}
```

</div>

## an improvement to naive primality testing

<span id="check-divisors-up-to-square-root" />

> **proposition 13.**
> If an integer \\( n \ge 2 \\) is composite, then it has a divisor
> \\( d \le \sqrt{n} \\).

> *proof:*
> We will prove this by contradiction.  Suppose that a number \\( n \\) is
> composite and taht is has no divisor less than or equal to its square root.
> Since it is composite, it may be expressed as \\( n = ab \\) for some pair of
> integers \\( a, b \\).  By hypothesis, both of these integers must be greater
> than \\( \sqrt{n} \\).  Then
> \\[ n = a \cdot b > \sqrt{n} \cdot \sqrt{n} = n, \\]
> which is a contradiction since an integer cannot be greater than itself.

The proposition may also be restated in its contrapositive form.

> **proposition 13.**
> If an integer \\( n \ge 2 \\) has no divisor less than or equal to its square
> root, then it is prime.

This rephrasing results in a substantial speed-up to our primality test above.

<span id="naive-primality" />

> **exercise.**
> Write an improved `is_prime_naive?` function that takes an integer input and
> returns `true` if it is prime and `false` otherwise.  It should use both the
> definition and the proposition.

```ruby
{{#include ../ruby/primality.rb:38:40}}
```

<button class="fa fa-expand" onClick="showContent('is_prime_naive')"></button>
<div id="is_prime_naive" style="display: none;">

```ruby
{{#include ../ruby/primality.rb:20:23}}
```

</div>

This algorithm is still quite slow. Its time complexity grows as the square
root of the input.  We will develop some probabilistic methods that are very
fast in a later section.

