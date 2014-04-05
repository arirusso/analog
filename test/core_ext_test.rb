require "helper"

class CoreExtTest < Test::Unit::TestCase

  context "Numeric" do

    setup do
      require "scale/core_ext"
    end

    context "#scaled" do

      should "amplify" do
        output = 0.10.scaled.using(0..1, 0..127)
        assert_equal(12, output)
      end

      should "deamplify" do
        output = 22.scaled.using(0..150, 0..15)
        assert_equal(2, output)
      end

      should "scale neg/pos into pos/pos" do
        output = 10.scaled.using(-24..24, 0..3.0)
        assert_equal(2.125, output)
      end

      should "scale neg/pos into another neg/pos" do
        output = 10.scaled.using(-24..24, -3..3.0)
        assert_equal(1.25, output)
      end

    end

    context "#scaled_using" do

      should "scale neg/neg into neg/pos" do
        output = -14.scaled_using(-24..-12, -3..3.0)
        assert_equal(2, output)  
      end

      should "scale neg/neg to another neg/neg" do
        output = -16.scaled_using(-24..-12, -5..-3.0)
        assert_equal(-3.666666666666667, output)
      end

      should "scale neg/neg to pos/pos" do
        output = -18.scaled_using(-24..-12, 1..3.0)
        assert_equal(2, output)
      end

    end

    context "#from" do

      should "take an array as the source" do
        output = 8.scaled.from([0, 2, 4, 8, 16, 64]).to(0..10)
        assert_equal(6, output)
      end

      should "output a float when specified" do
        output = 12.scaled.from(0..120).to(0..1.0)
        assert_equal(0.10, output)   
      end

    end

    context "#scaled_from" do

      should "take an ascending array as the destination" do
        output = 0.40.scaled_from(0..1).to([0, 2, 4, 8, 12, 16, 32, 64, 128, 512])
        assert_equal(8, output)
      end

      should "take a descending array as the destination" do
        output = 0.40.scaled_from(0..1).to([512, 128, 64, 32, 16, 12, 8, 4, 2, 0])
        assert_equal(32, output)
      end

    end

  end

end
