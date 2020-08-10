#-----------------------------
# divides?: 4-11

def divides?(b, a)
  m = 0
  while m < a
    m += b
  end

  m == a
end

#-----------------------------
# div_rem: 16-22

def div_rem(a, b)
  rem = a % b
  rem += b.abs if rem < 0
  quo = (a - rem) / b

  [quo, rem]
end

#-----------------------------
# naive_gcd: 27-37

def naive_gcd(a, b)
  divisor = 1
  upper_bound = [a.abs, b.abs].min
  (2..upper_bound).each do |i|
    if a % i == 0 && b % i == 0
      divisor = i
    end
  end

  divisor
end

#-----------------------------
# euclidean_algorithm: 42-48

def euclidean_algorithm(a, b)
  while b != 0
    quo, rem = div_rem(a, b)
    puts "#{a} == #{b} * #{quo} + #{rem}"
    a, b = b, rem
  end
end

#-----------------------------
# gcd: 53-61

def gcd(a, b)
  return if a == 0 && b == 0

  while b != 0
    a, b = b, a % b
  end

  a.abs
end

#-----------------------------
# bezout: 66-80

def bezout(a, b)
  return if a == 0 && b == 0

  prev, curr = [[1, 0], [0, 1]]

  while b != 0
    quo, rem = div_rem(a, b)
    nxt = [0, 1].map { |i| prev[i] - curr[i] * quo }

    a, b = b, rem
    prev, curr = curr, nxt
  end

  a < 0 ? prev.map { |u| -u } : prev
end

#-----------------------------
# naive_lcm: 85-96

def naive_lcm(a, b)
  return if a == 0 || b == 0

  smaller, larger = [a, b].map(&:abs).sort

  multiple = larger
  while multiple % smaller != 0
    multiple += larger
  end

  multiple
end

#-----------------------------
# lcm: 101-105

def lcm(a, b)
  return if a == 0 || b == 0

  ((a / gcd(a, b)) * b).abs
end

