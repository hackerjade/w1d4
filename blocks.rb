require 'byebug'

class Array
  def my_each(&proc)
    idx = 0
    while idx < self.length
      proc.call(self[idx])
      idx += 1
    end

    self
  end

  def my_map(&proc)
    duplicate = []
    self.my_each do |el|
      duplicate << proc.call(el)
    end

    duplicate
  end

  def my_select(&proc)
    selected = []
    self.my_each do |el|
      selected << el if proc.call(el)
    end

    selected
  end

  # array = [1, 2, 3]
  # array.take(1) => [1]
  # array.drop(1) => [2, 3]

  def my_inject(&proc)
    result = self.first
    self.drop(1).my_each do |el|
      result = proc.call(result, el)
    end

    result
  end

  def my_sort!(&prc)
    return self if self.length <= 1

    current_num = self[0]
    left_half = []
    right_half = []

    self.each_with_index do |num, idx|
      if idx == 0
        next
      else
        comparison = prc.call(current_num, num)

        if comparison == -1 # when x < y
          right_half << num
        elsif comparison == 1 || comparison == 0
          left_half << num
        end
      end
    end

    left_half.my_sort!(&prc) + [current_num] + right_half.my_sort!(&prc)
  end
end

def eval_block(*arg, &prc)
  prc.nil? ? puts("NO BLOCK GIVEN") : prc.call(*arg)

  # ask about asterisk
end

eval_block("foo", "bar")
