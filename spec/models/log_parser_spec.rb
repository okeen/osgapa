require 'spec_helper'
require 'log_parser'

describe LogParser, type: :model do
  subject{ LogParser.new }

  describe "parse" do
    context "with some valid file entries" do
      let(:entries) { ["/help_page/1 126.318.035.038"] }

      it "calls to parse each entry" do
        entries.each do |entry|
          expect(subject).to receive(:parse_entry).with(entry)
        end
        subject.parse(entries)
      end

      it "returns the computed LogVisitsResult" do
        result = subject.send(:result_set)
        expect(subject.parse(entries)).to eq(result)
      end
    end
  end

  describe "parse_entry" do
    context "with a valid log entry" do
      let(:entry) { "/help_page/1 126.318.035.038" }

      it "returns the result to call to split the entry string by whitespaces" do
        expect(entry).to receive(:split).with(" ").and_return(:something)
        expect(subject.send(:parse_entry, entry)).to eq :something
      end
    end
  end

  describe "result_set" do
    it "returns a cached instance over and over again" do
      result_set = subject.send(:result_set)
      5.times do |index|
        expect(subject.send(:result_set).__id__).to eq result_set.__id__
      end
    end

    it "returns a LogVisitsResult instance" do
      expect(subject.send(:result_set)).to be_an_instance_of(LogVisitsResult)
    end
  end
end
