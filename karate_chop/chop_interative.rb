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

def chop(target, array_of_int)
  #
  puts "test: #{target} #{array_of_int}"
  if array_of_int.nil? || array_of_int.empty?
    -1
  else
    index = array_of_int.size / 2
    result_index = index
    puts "start: #{index}"
    while index > -1 do
      if index < 0 || (index == 0 and target != array_of_int[index])
        puts "not found"
        index = -1
        result_index = -1
      elsif target == array_of_int[index]
        puts "found it #{result_index}"
        index = -1
      elsif target < array_of_int[index]
        array_of_int = array_of_int.take array_of_int.size / 2
        index = array_of_int.size / 2
        result_index = index
        puts "bottom: #{index} #{array_of_int} #{result_index}"
      else
        array_of_int = array_of_int.drop array_of_int.size / 2
        index = array_of_int.size / 2
        result_index = result_index + index
        puts "top: #{index} #{array_of_int} #{result_index}"
      end

    end
    result_index
  end
end
