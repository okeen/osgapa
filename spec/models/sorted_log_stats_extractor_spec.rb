require 'spec_helper'
require 'sorted_log_stats_extractor'

describe SortedLogStatsExtractor, type: :model do
  describe "process" do
    subject { SortedLogStatsExtractor.new }

    let!(:log_file_name) { 'webserver.oneline.log' }
    let(:log_entry) { '/help_page/1 126.318.035.038' }

    it "calls to load the file name and delegates the extraction top the " do
      expect(subject).to receive(:load_file_contents).with(log_file_name).and_return [log_entry]
      parser = LogParser.new
      expect(LogParser).to receive(:new).and_return parser
      expect(parser).to receive(:parse).with [log_entry]

      subject.process(log_file_name)
    end

    context "with an invalid log file name" do
      let!(:log_file_name) { 'not_found.log' }

      it "returns nil if the file is not found" do
        expect(subject.process(log_file_name)).to be_nil
      end
    end
  end

  describe "load_file_contents" do
    let!(:log_file_name) { 'webserver.oneline.log' }

    it "delegates the file load into File#open" do
      file_handler = double(readlines: [1])
      expect(File).to receive(:open).with(log_file_name).and_return file_handler
      expect(file_handler).to receive(:readlines)

      subject.send(:load_file_contents, log_file_name)
    end

    context "with an invalid file name" do
      let!(:log_file_name) { 'webserver.oneline.log' }

      it "expects the caller to handle the exception raised by File#open" do
        expect { subject.send(:load_file_contents, log_file_name) }.to raise_error(Errno::ENOENT)
      end
    end
  end
end
