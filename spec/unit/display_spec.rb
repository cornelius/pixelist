require_relative "spec_helper.rb"

include GivenFilesystemSpecHelpers

describe Display do
  use_given_filesystem

  describe "#show" do
    it "shows 1 pixel" do
      subject.set(".")

      expect {
        subject.show
      }.to output("+-+\n| |\n+-+\n").to_stdout
    end

    it "shows 2x2 matrix" do
      subject.set(".X\nX.")

      expect {
        subject.show
      }.to output("+--+\n| O|\n|O |\n+--+\n").to_stdout
    end
  end

  describe "#load" do
    it "loads matrix from file" do
      subject.load(given_file("simple.pixels"))

      expect(subject.matrix).to eq("101\n010\n101\n")
      expect(subject.width).to eq(3)
      expect(subject.height).to eq(3)
    end
  end

  describe "#set_pixel" do
    before do
      subject.set("..\n..\n")
    end

    it "sets pixel with x:0 and y:0" do
      subject.set_pixel(x: 0,y: 0)

      expect(subject.matrix).to eq("10\n00\n")
    end

    it "sets pixel with x:1 and y:0" do
      subject.set_pixel(x: 1,y: 0)

      expect(subject.matrix).to eq("01\n00\n")
    end

    it "sets pixel with x:0 and y:1" do
      subject.set_pixel(x: 0,y: 1)

      expect(subject.matrix).to eq("00\n10\n")
    end

    it "sets pixel with x:1 and y:1" do
      subject.set_pixel(x: 1,y: 1)

      expect(subject.matrix).to eq("00\n01\n")
    end

    it "sets state when provided as optional argument" do
      subject.set("10\n00\n")

      subject.set_pixel(x:0, y:0, state: false)

      expect(subject.matrix).to eq("00\n00\n")
    end

    context "with borders" do
      before do
        subject.enable_borders = true
      end

      it "throws exception when pixel is out of width range" do
        expect {
          subject.set_pixel(x: 2, y: 1)
        }.to raise_error(PixelistError)
      end

      it "throws exception when pixel is out of height range" do
        expect {
          subject.set_pixel(x: 1, y: 2)
        }.to raise_error(PixelistError)
      end
    end

    context "without borders" do
      before do
        subject.enable_borders = false
      end

      it "wraps around positive width" do
        subject.set_pixel(x: 2, y: 1)
        expect(subject.matrix).to eq("00\n10\n")
      end

      it "wraps around positive height" do
        subject.set_pixel(x: 1, y: 2)
        expect(subject.matrix).to eq("01\n00\n")
      end

      it "wraps around negative width" do
        subject.set_pixel(x: -1, y: 1)
        expect(subject.matrix).to eq("00\n01\n")
      end

      it "wraps around negative height" do
        subject.set_pixel(x: 1, y: -1)
        expect(subject.matrix).to eq("00\n01\n")
      end
    end
  end

  describe "#unset_pixel" do
    it "calls set_pixel with state `false`" do
      expect(subject).to receive(:set_pixel).with(hash_including(state:false))

      subject.unset_pixel(x:0, y:0)
    end
  end

  describe "#pixel" do
    before do
      subject.set("10\n00\n")
    end

    it "gets pixel within borders" do
      expect(subject.pixel(x:0, y:0)).to eq(true)
      expect(subject.pixel(x:1, y:0)).to eq(false)
      expect(subject.pixel(x:0, y:1)).to eq(false)
      expect(subject.pixel(x:1, y:1)).to eq(false)
    end

    context "with borders" do
      before do
        subject.enable_borders = true
      end

      it "throws error when x is more than width" do
        expect {
          subject.pixel(x:2, y:0)
        }.to raise_error PixelistError
      end

      it "throws error when x is less than zero" do
        expect {
          subject.pixel(x:-1, y:0)
        }.to raise_error PixelistError
      end

      it "throws error when y is more than height" do
        expect {
          subject.pixel(x:0, y:2)
        }.to raise_error PixelistError
      end

      it "throws error when y is less than height" do
        expect {
          subject.pixel(x:0, y:-1)
        }.to raise_error PixelistError
      end
    end

    context "without borders" do
      before do
        subject.enable_borders = false
      end

      it "gets pixel when x is more than width" do
        expect(subject.pixel(x:2, y:0)).to be(true)
        expect(subject.pixel(x:3, y:0)).to be(false)
      end

      it "gets pixel when x is less than zero" do
        expect(subject.pixel(x:-1, y:0)).to be(false)
        expect(subject.pixel(x:-2, y:0)).to be(true)
      end

      it "gets pixel when y is more than height" do
        expect(subject.pixel(x:0, y:2)).to be(true)
        expect(subject.pixel(x:0, y:3)).to be(false)
      end

      it "gets pixel when y is less than height" do
        expect(subject.pixel(x:0, y:-1)).to be(false)
        expect(subject.pixel(x:0, y:-2)).to be(true)
      end
    end
  end

  describe "#set" do
    it "sets width for 1 pixel" do
      subject.set(".")

      expect(subject.width).to eq(1)
    end

    it "sets width for 2x2 matrix" do
      subject.set("..\n..\n")

      expect(subject.width).to eq(2)
    end

    it "sets height for 1 pixel" do
      subject.set(".")

      expect(subject.height).to eq(1)
    end

    it "sets height for 2x2 matrix" do
      subject.set("..\n..\n")

      expect(subject.height).to eq(2)
    end
  end

  describe "#normalize_matrix" do
    it "treats . as 0" do
      expect(subject.normalize_matrix("..\n..\n")).to eq(["00\n00\n", 2, 2])
    end

    it "treats 0 as 0" do
      expect(subject.normalize_matrix("00\n00\n")).to eq(["00\n00\n", 2, 2])
    end

    it "treats 1 as 1" do
      expect(subject.normalize_matrix("1.\n1.\n")).to eq(["10\n10\n", 2, 2])
    end

    it "treats X as 1" do
      expect(subject.normalize_matrix("X.\nX.\n")).to eq(["10\n10\n", 2, 2])
    end
  end

  describe "#clear" do
    it "clears matrix" do
      subject.set("10\n11\n")

      subject.clear

      expect(subject.matrix).to eq("00\n00\n")
    end
  end

  describe "#init" do
    it "inits matrix" do
      subject.init(width: 2, height: 3)

      expect(subject.matrix).to eq("00\n00\n00\n")
    end

    it "returns display object" do
      expect(subject.init(width: 1, height: 1)).to be_a(Display)
    end

    it "sets width" do
      expect(subject.init(width: 3, height: 1).width).to eq(3)
    end

    it "sets height" do
      expect(subject.init(width: 3, height: 1).height).to eq(1)
    end
  end

  describe "#save" do
    it "saves to file used for load" do
      filename = given_file("simple.pixels")
      subject.load(filename)

      subject.save
      expect(subject.filename).to eq(filename)
    end

    it "saves to given file" do
      subject.load(given_file("simple.pixels"))
      filename = given_dummy_file

      subject.save(filename)
      expect(subject.filename).to eq(filename)
    end

    it "does nothing when no file is set" do
      expect {
        subject.save
      }.to_not raise_error
    end
  end
end
