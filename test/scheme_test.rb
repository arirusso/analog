require "helper"

class Scale::SchemeTest < Minitest::Test

  context "Scheme" do

    context ".transform" do

      should "amplify" do
        output = Scale.transform(0.10).using(0..1, 0..127)
        assert_equal(12, output)
      end

    end

    context ".from" do

      should "deamplify" do
        output = Scale.from(0..150).to(0..15).transform(22)
        assert_equal(2, output)
      end

    end

    context ".to" do

      should "scale neg/pos into pos/pos" do
        output = Scale.to(0..3.0).from(-24..24).transform(10)
        assert_equal(2.125, output)
      end

    end

    context ".using" do

      should "scale neg/pos into another neg/pos" do
        output = Scale.using(-24..24, -3..3.0).transform(10)
        assert_equal(1.25, output)
      end

    end

  end

end
