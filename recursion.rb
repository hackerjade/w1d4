require 'byebug'

def range(start,finish)
  if finish < start
    []
  else
    [start] + range(start + 1, finish)
  end
end

def inter_sum(array)
  array.inject(:+)
end

def recur_sum(array)
  return array[0] if array.length == 1
  array[0] + recur_sum(array.drop(1))
  # sum = array[0] + array[1]
  # new_array = [sum] + array[2..-1]
  # recur_sum(new_array)
end

def recur_1(b, n)
  n == 0 ? 1 : b * recur_1(b, (n - 1))
end

def recur_2(b, n)
  if n == 0
    1
  elsif n == 1
    b
  elsif n.even?
    recur_2(b, (n / 2)) * recur_2(b, (n / 2))
  else
    b * (recur_2(b, ((n - 1) / 2)) * recur_2(b, ((n - 1) / 2)))
  end
end

def deep_dup(array)
  new_array = array.map do |el|
    if el.is_a?(Array)
      el.length == 1 ? dup(el) : deep_dup(el)
      # el[0].is_a?(Array)
    else
      el
    end
  end
    #el + dup(el) + deep_dup(el)
    p new_array
end

def dup(array)
  new_array = []
  array.each { |el| new_array << el }
  new_array
end

def iter_fib(num)
  fib_array = [1,1]

  until fib_array.length == num
    fib_array << (fib_array[-1] + fib_array[-2])
  end

   fib_array
end

def recur_fib(num)
  if num == 2
    [1, 1]
  else
    recur_fib(num - 1) << (recur_fib(num -1 )[-1] + recur_fib(num - 1)[-2])
   end
end

def bsearch(array, target)
  middle = (array.length / 2)
  left_half = array[0...middle]

  if array.length.odd?
    right_half = array[(middle + 1)..- 1]
    middle_number = array[middle]
  else
    right_half = array[middle..- 1]
    middle_number = (array[middle - 1] + array[middle]) / 2
  end
  # byebug
  if target == middle_number
    return array.index(middle_number)
  elsif target > middle_number && array.length > 1
    middle + bsearch(right_half, target)
  elsif target < middle_number && array.length > 1
    bsearch(left_half, target)
  else
    nil
  end
end
