require "helper"

class Scale::DestinationTest < Test::Unit::TestCase

  context "Destination" do

    context ".new" do

      should "recognize a Range" do
        dest = Scale::Destination.new(0..1)
        assert_equal(Scale::Destination::Range, dest.class)
      end

      should "recognize an Array" do
        dest = Scale::Destination.new([0, 10, 20, 50])
        assert_equal(Scale::Destination::Enumerable, dest.class)
      end

      should "recognize an Set" do
        dest = Scale::Destination.new(Set.new([0, 10, 20, 50]))
        assert_equal(Scale::Destination::Enumerable, dest.class)
      end

    end

  end

end

