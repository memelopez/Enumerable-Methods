module Enumerable
    def my_each
        return to_enum(:my_each) unless block_given?

        to_a.length.times do |i|
            yield(to_a[i])
        end
        self
    end

    def my_each_with_index
        return to_enum(:my_each_with_index) unless block_given?

        to_a.length.times do |i|
            yield(to_a[i], i)
        end
        self
    end

    def my_select
        return to_enum(:my_select) unless block_given?

        result = []
        to_a.my_each { |i| result << i if yield(i) }
        result
    end

    def my_all?(param = nil)
        if !block_given? && !param
          to_a.my_each { |val| return false unless val }
        elsif param.is_a?(Class)
          to_a.my_each { |val| return false unless val.is_a?(param) }
        elsif param.is_a?(Regexp)
          to_a.my_each { |val| return false unless param.match(val) }
        elsif param
          to_a.my_each { |val| return false unless val == param }
        else
          to_a.my_each { |val| return false unless yield(val) }
        end
        true
    end

    def my_any?(param = nil)
        if !block_given? && !para
          to_a.my_each { |val| return true if val }
        elsif param.is_a?(Class)
          to_a.my_each { |val| return true if val.is_a?(param) }
        elsif param.is_a?(Regexp)
          to_a.my_each { |val| return true if param.match(val) }
        elsif param
          to_a.my_each { |val| return true if val == param }
        else
          to_a.my_each { |val| return true if yield(val) }
        end
        false
    end
end

def my_none?
  self.my_each do |i|
    if yield(i) == true
      return false
    end
  end
  return true
end

def my_count
  count = 0
  self.my_each do |i|
    if yield(i) == true
      count += 1
    end
  end
  count
end

def my_map(proc = nil)
  var = []
  if proc
    self.my_each do |i|
    var << proc.call(i)
    end
  elsif block_given?
    self.my_each do |i|
    var << yield(i)
    end
  end
  var
end

def my_inject
  var = self.first
  self.my_each do |i, j|
    next if j.zero?

    var = yield(var, i)
  end
  var
end

def multiply_els(arr)
  arr.my_inject do |i, j|
    i * j
  end
end
