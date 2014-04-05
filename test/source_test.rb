require "helper"

class Scale::SourceTest < Test::Unit::TestCase

  context "Source" do

    context ".new" do

      should "recognize a Range" do
        source = Scale::Source.new(0..1)
        assert_equal(Scale::Source::Range, source.class)
      end

      should "recognize an Array" do
        source = Scale::Source.new([0, 10, 20, 50])
        assert_equal(Scale::Source::Enumerable, source.class)
      end

      should "recognize an Set" do
        source = Scale::Source.new(Set.new([0, 10, 20, 50]))
        assert_equal(Scale::Source::Enumerable, source.class)
      end

    end

  end

end
