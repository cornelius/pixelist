require_relative "../../lib/pixelist"
require_relative "../life"

describe Life do
  subject { Life.new(display) }
  let(:display) {
    display = Display.new
    display.set(matrix)
    display
  }

  describe "#calculate neighbors" do
    context "0 neighbors" do
      let(:matrix) { "000\n000\n000\n" }

      it "returns 0" do
        expect(subject.count_neighbours(x:1, y:1)).to eq(0)
      end
    end

    context "1 neighbors" do
      let(:matrix) { "100\n000\n000\n" }

      it "returns 1" do
        expect(subject.count_neighbours(x:1, y:1)).to eq(1)
      end
    end

    context "2 neighbors" do
      let(:matrix) { "000\n101\n000\n" }

      it "returns 2" do
        expect(subject.count_neighbours(x:1, y:1)).to eq(2)
      end
    end

    context "3 neighbors" do
      let(:matrix) { "111\n000\n000\n" }

      it "returns 3" do
        expect(subject.count_neighbours(x:1, y:1)).to eq(3)
      end
    end

    context "4 neighbors" do
      let(:matrix) { "101\n000\n101\n" }

      it "returns 4" do
        expect(subject.count_neighbours(x:1, y:1)).to eq(4)
      end
    end
  end
end
