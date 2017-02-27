require_relative "spec_helper"

class MyWorker < Worker
  def start
  end

  def step
    @count ||= 0
    @count += 1
    @count < 5
  end
end

describe Worker do
  let(:display) { Display.new.init(width: 2, height: 2) }
  subject { MyWorker.new(display) }

  describe "#run" do
    before do
      allow(Kernel).to receive(:sleep)
    end

    it "calls start" do
      expect(subject).to receive(:start).once

      subject.run(count: 3)
    end

    it "calls step given times" do
      expect(subject).to receive(:step).exactly(3).times.and_return(true)

      subject.run(count: 3)

      expect(subject.step_count).to equal(3)
    end

    it "runs until step returns false" do
      subject.run

      expect(subject.step_count).to equal(5)
    end

    it "sleeps for specified duration, when argument is passed" do
      expect(Kernel).to receive(:sleep).with(0.3).exactly(2).times

      subject.run(count: 2, sleep: 0.3)
    end

    it "doesn't sleep if sleep argument is nil" do
      expect(Kernel).to_not receive(:sleep)

      subject.run(count: 2, sleep: nil)
    end

    it "saves display after each step" do
      expect(display).to receive(:save).exactly(3).times

      subject.run(count: 3)
    end

    it "shows matrix if option is set" do
      expected_output = <<EOT
Pixelist MyWorker (step 1)
+--+
|  |
|  |
+--+
EOT
      expect(subject).to receive(:system).with("clear")

      expect {
        subject.run(count: 1, show: true)
      }.to output(expected_output).to_stdout
    end
  end

  it "has access to display" do
    expect(subject.display).to be_a(Display)
  end
end
