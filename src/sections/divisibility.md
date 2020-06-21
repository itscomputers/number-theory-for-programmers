# divisibility

This study of integers begins with the notion of divisibility: whether the
division of two integers results in an integer.  Because of the volatile nature
of division, we frame this question in terms of integer multiplication.

> A nonzero integer \\( b \\) **divides** an integer \\( a \\) if there exists
> some integer \\( n \\) such that \\( a = bn \\).

Here are a few examples:
- 15 divides 45 since \\( 45 = 15 \cdot 3 \\)
- 9 divides 45 since \\( 45 = 9 \cdot 5 \\)
- 10 does not divide 45 since 45 is between
\\( 40 = 10 \cdot 4 \\) and \\( 50 = 10 \cdot 5 \\)

The above definition is synonymous with saying that \\( b \\)
may be expressed as a multiple of \\( a \\).  In fact, the following
statements are equivalent and mean that \\( a \\) is can be expressed as
\\( bn \\).
- \\( b \\) divides \\( a \\)
- \\( b \\) is a divisor of \\( a \\)
- \\( a \\) is divisible by \\( b \\)
- \\( a \\) is a multiple of \\( b \\)

The notation for this concept is \\( b \mid a \\), which reads "\\( b \\)
divides \\( a \\)".  Using this notation, the examples above become:
- \\( 15 \mid 45 \\) since \\( 45 = 15 \cdot 3 \\)
- \\( 9 \mid 45 \\) since \\( 45 = 9 \cdot 5 \\)
- \\( 10 \nmid 45 \\) since \\( 10 \cdot 4 < 45 < 10 \cdot 5 \\)

Be careful!  This notation may sometimes be confused with the division
operation. If you see \\( 15 / 45 \\), it is the operation that returns
the rational number \\( 1/3 \\).  If you see \\( 15 \mid 45 \\), it is the
statement that \\( 45 \\) is divisible by \\( 15 \\), ie, that \\( 45 / 15 \\)
is an integer.

<span id="divides-exercise" />

> **exercise.**
> Using **only** addition, multiplication, and comparison, write a `divides`
> function that takes as input two *positive* integers `b` and `a` and returns
> `true` if `b` divides `a` and `false` otherwise.

With such a `divides?` function in ruby, the following code should yield the
terminal output below.

```ruby
{{#include ../ruby/division.rb:15:29}}
```

```
25 divides 0
31 does not divide 432
87 divides 5046
99 divides 9900
9900 does not divide 99
```

Click the button below to show an implementation of a simple `divides?`
function in ruby.

<button class="fa fa-expand" onClick="showContent('divides')"></button>
<div id="divides" style="display: none;">

```ruby
{{#include ../ruby/division.rb:6:13}}
```

</div>

## linear combinations

> An **integer linear combination** of integers \\( a \\) and \\( b \\) is an
> integer of the form \\( ax + by \\) where \\( x \\) and \\( y \\) are integers.

For example, 11 through 15 can all be expressed as linear
combinations of 5 and 6.  Here are two examples of each.

\\[\begin{align}
5(1) + 6(1) &= 11 = 5(7) + 6(-4) \\\\
5(0) + 6(2) &= 12 = 5(6) + 6(-3) \\\\
5(-1) + 6(3) &= 13 = 5(5) + 6(-2) \\\\
5(-2) + 6(4) &= 14 = 5(4) + 6(-1) \\\\
5(-3) + 6(5) &= 15 = 5(3) + 6(0) \\\\
\end{align}\\]

The following proposition about integer linear combinations will be used
often.

<span id="linear-combination" />

> **proposition 1.**
> If \\( d \\) is a common divisor of \\( a \\) and \\( b \\), then \\( d \\)
> divides any integer linear combination of \\( a \\) and \\( b \\).

> *proof:*
> Suppose that \\( d \\) divides \\( a \\) and \\( b \\).  By definition, there
> exist integers \\( m, n \\) such that \\( a = dm \\) and \\( b = dn \\).  Let
> \\( c = ax + by \\) be an integer linear combination of \\( a \\) and
> \\( b \\).  For any linear combination \\( ax + by \\),
> \\[ ax + by = (dm)x + (dn)y = d(mx + ny). \\]
> Since \\( mx + ny \\) is an integer, the linear combination is divisible by
> \\( d \\).

<span id="exercises" />

## exercises

1. Prove that any nonzero integer divides 0.

2. Prove that 1 and -1 divide any integer.

3. Prove that any nonzero integer divides itself.

4. If \\( a \\) and \\( b \\) are positive integers and \\( b \\) divides \\( a
   \\), prove that \\( b \le a \\).

5. Prove that two positive integers that divide each other must be equal.

6. Prove that the **divides** relation is *transitive*: if \\( c \mid b \\) and
   \\( b \mid a \\), prove that \\( c \mid a \\).

7. If \\( d \\) divides both \\( a \\) and \\( b \\), prove that \\( d \\)
   divides their sum \\( a + b \\).

8. Disprove the converse of the previous exercise by producing a
   counter-example.

9. If \\( d \\) divides either \\( a \\) or \\( b \\), prove that \\( d \\)
   divides their product \\( ab \\).

10. Disprove the converse of the previous exercise by producing a
    counter-example.

<button onClick="showContent('solutions')">show solutions</button>
<div id="solutions" style="display: none;">

1. For \\( n \\) nonzero, we have \\( 0 = n \cdot 0 \\), so \\( n \\) divides
   \\( 0 \\).

2. For any \\( n \\), we have \\( n = 1 \cdot n \\) and \\( n = -1 \cdot -n \\),
   so both \\( 1 \\) and \\( -1 \\) divide \\( n \\).

3. For \\( n \\) nonzero, we have \\( n = n \cdot 1 \\), so \\( n \\) divides
   itself.

4. Let \\( a \\) and \\( b \\) be positive integers such that
   \\( b \mid a \\).  Then \\( a = bk \\) for some integer \\( k \\).
   Since \\( a \\) and \\( b \\) are both positive, then so is \\ ( k \\).
   This means that \\( k \ge 1 \\), which implies that \\( a = bk \ge b \\).

5. Let \\( a \\) and \\( b \\) be two positive integers that divide each other.
   From the previous exercise, we have \\( a \le b \\) and \\( b \le a \\), so
   \\( a \\) and \\( b \\) must be equal.

6. Suppose that \\( c \mid b \\) and \\( b \mid a \\).  We can write
   \\( c = bm \\) and \\( b = an \\).  Therefore, \\( c = (an)m = a(mn) \\),
   which proves that \\(c \mid a \\).

7. Since the sum \\( a + b \\) is a linear combination of \\( a \\) and
   \\( b \\), then the proposition implies that \\( a + b \\) is divisible by
   any common divisor \\( d \\) of \\( a \\) and \\( b \\).

8. Take \\( a = 3 \\), \\( b = 7 \\), and \\( d = 5 \\).  Then \\( d \\)
   divides the sum \\( a + b = 10 \\) but does not divide either \\( a \\) or
   \\( b \\).

9. If \\( d \\) divides \\( a \\), then \\( a = dn \\), so \\( ab = d(bn) \\).
   If \\( d \\) divides \\( b \\), then \\( b = dm \\), so \\( ab = d(am) \\).
   Either way, \\( d \\) divides the product \\( ab \\).

10. Take \\( a = 4 \\), \\( b = 3 \\), and \\( d = 6 \\).  Then \\( d \\)
    divides the product \\( ab = 12 \\) but does not divide either \\( a \\) or
    \\( b \\).

</div>
