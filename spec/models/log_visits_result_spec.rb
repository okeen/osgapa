require 'spec_helper'
require 'log_visits_result'

describe LogVisitsResult, type: :model do
  subject { LogVisitsResult.new }
  describe "add" do
    context "with an empty sheet" do
      it "has no visits" do
        expect(subject.visits).to be_empty
      end

      it "adds one to the visits of that IP address on that path" do
        subject.add(:path1, :ip1)
        expect(subject.visits[:path1][:ip1]).to eq 1
      end
    end

    context "a new unique visit to a path" do
      before do
        subject.add(:path1, :ip1)
      end

      it "adds one to the visits of that IP address on that path" do
        subject.add(:path1, :ip1)
        expect(subject.visits[:path1][:ip1]).to eq 2
      end
    end

    context "with invalid file entries" do
      let(:entries) { [""] }

      it "doesn't add any item" do
        subject.add()
        expect(subject.visits.count).to eq 0
      end

      it "returns nil" do
        expect(subject.add).to be_nil
      end
    end
  end

  describe "visits" do
    it "returns a cached instance over and over again" do
      visits = subject.send(:visits)
      5.times do |index|
        expect(subject.send(:visits).__id__).to eq visits.__id__
      end
    end

    it "returns a Hash instance" do
      expect(subject.send(:visits)).to be_an_instance_of(Hash)
    end
  end

  describe "to_a" do
    let!(:unique_only) { false }

    before do
      subject.add(:path1, :ip1)
    end

    after do
      subject.to_a(unique_only)
    end

    it "maps the visits with the result items and sorts the result" do
      expect(subject.visits).to receive(:map)
    end

    it "maps the visits with the result items and sorts the result" do
      expect(subject).to receive(:sort_by_unique_visits)
    end

    context "with unique = false" do

      it "maps the visits with the result items and sorts the result" do
        expect(subject).to receive(:result_item).with(:path1, ip1: 1)
      end
    end

    context "with unique = true" do
      let!(:unique_only) { true }

      it "maps the visits with the result items and sorts the result" do
        expect(subject).to receive(:unique_result_item).with(:path1, ip1: 1)
      end
    end
  end

  describe "result_item" do
    let(:visits) { {path: { ip1: 2, ip2: 2 }} }

    it "returns the total sum of visits into that path" do
      expect(subject.send(:result_item, :path, visits[:path])).to eq([:path, 4])
    end
  end

  describe "unique_result_item" do
    let(:visits) { {path: { ip1: 2, ip2: 2 }} }

    it "returns the total sum of visits into that path" do
      expect(subject.send(:unique_result_item, :path, visits[:path])).to eq([:path, 2])
    end
  end
end
