require "helper"

class ScaleTest < Minitest::Test

  context "Scale" do

    context "#transform" do

      should "amplify" do
        output = Scale.transform(0.10).using(0..1, 0..127)
        assert_equal(12, output)
      end

      should "deamplify" do
        output = Scale.transform(22).using(0..150, 0..15)
        assert_equal(2, output)
      end

      should "scale neg/pos into pos/pos" do
        output = Scale.transform(10).using(-24..24, 0..3.0)
        assert_equal(2.125, output)
      end

      should "scale neg/pos into another neg/pos" do
        output = Scale.transform(10).using(-24..24, -3..3.0)
        assert_equal(1.25, output)
      end

      should "scale neg/neg into neg/pos" do
        output = Scale.transform(-14).using(-24..-12, -3..3.0)
        assert_equal(2, output)
      end

      should "scale neg/neg to another neg/neg" do
        output = Scale.transform(-16).using(-24..-12, -5..-3.0)
        assert_equal(-3.666666666666667, output)
      end

      should "scale neg/neg to pos/pos" do
        output = Scale.transform(-18).using(-24..-12, 1..3.0)
        assert_equal(2, output)
      end

      should "take an array as the source" do
        output = Scale.transform(8).using([0, 2, 4, 8, 16, 64], 0..10)
        assert_equal(6, output)
      end

      should "take an set as the source" do
        output = Scale.transform(8).using(Set.new([0, 2, 4, 8, 16, 64]), 0..10)
        assert_equal(6, output)
      end

      should "output a float when specified" do
        output = Scale.transform(12).using(0..120, 0..1.0)
        assert_equal(0.10, output)
      end

      should "take an ascending array as the destination" do
        output = Scale.transform(0.40).using(0..1, [0, 2, 4, 8, 12, 16, 32, 64, 128, 512])
        assert_equal(8, output)
      end

      should "take a descending array as the destination" do
        output = Scale.transform(0.40).using(0..1, [512, 128, 64, 32, 16, 12, 8, 4, 2, 0])
        assert_equal(32, output)
      end

      should "take a set as the destination" do
        output = Scale.transform(0.40).using(0..1, Set.new([0, 2, 4, 8, 12, 16, 32, 64, 128, 512]))
        assert_equal(8, output)
      end

    end

  end

end
