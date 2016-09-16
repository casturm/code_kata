require "minitest/autorun"

class TestChop < Minitest::Test

  def test_chop
    assert_equal(-1, chop(3, []))
    assert_equal(-1, chop(3, [1]))
    assert_equal(0,  chop(1, [1]))
    #
    assert_equal(0,  chop(1, [1, 3, 5]))
    assert_equal(1,  chop(3, [1, 3, 5]))
    assert_equal(2,  chop(5, [1, 3, 5]))
    assert_equal(-1, chop(0, [1, 3, 5]))
    assert_equal(-1, chop(2, [1, 3, 5]))
    assert_equal(-1, chop(4, [1, 3, 5]))
    assert_equal(-1, chop(6, [1, 3, 5]))
    #
    assert_equal(0,  chop(1, [1, 3, 5, 7]))
    assert_equal(1,  chop(3, [1, 3, 5, 7]))
    assert_equal(2,  chop(5, [1, 3, 5, 7]))
    assert_equal(3,  chop(7, [1, 3, 5, 7]))
    assert_equal(-1, chop(0, [1, 3, 5, 7]))
    assert_equal(-1, chop(2, [1, 3, 5, 7]))
    assert_equal(-1, chop(4, [1, 3, 5, 7]))
    assert_equal(-1, chop(6, [1, 3, 5, 7]))
    assert_equal(-1, chop(8, [1, 3, 5, 7]))
  end
end

module ChopExtensions
  module Array
    def middle
      self.size / 2
    end

    def bottom?(target)
      self[middle] > target
    end

    def bottom
      self.take middle
    end

    def top?(target)
      self[middle] <= target
    end

    def top
      self.drop middle
    end
  end
end

Array.include ChopExtensions::Array

def chop(target, array_of_int)
  puts
  puts "test: #{target} #{array_of_int}"
  if Array(array_of_int).empty? or
     array_of_int.size == 1 and array_of_int[0] != target
    -1
  elsif array_of_int.size == 1 and array_of_int[0] == target
    0
  elsif array_of_int.bottom?(target)
    chop(target, array_of_int.bottom)
  elsif array_of_int.top?(target)
    if chop(target, array_of_int.top) > -1
      chop(target, array_of_int.top) + array_of_int.middle
    else
      -1
    end
  else
    -1
  end
end

