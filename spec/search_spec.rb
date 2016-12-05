require "spec_helper"

describe Togglapper do
  include_context 'With create client'
  describe "#entries" do
    before(:all) { @entries = @client.entries }
    it "return entries" do
      puts @entries
      expect(@entries).to be_truthy
    end
  end

  describe "#last_entry" do
    before(:all) { @entry = @client.latest_entry }
    it "return entry" do
      puts @entry
      expect(@entry).to be_truthy
    end
  end

  describe "#entries_by_tags" do
    before(:all) { @entries = @client.entries_by_tags("#2661") }
    it "return entries" do
      puts @entries
      expect(@entries).to be_truthy
    end
  end

  describe "#entry_info" do
    before(:all) { @entry = @client.entry_info(@client.latest_entry) }
    it "return entry" do
      puts @entry
      expect(@entry).to be_truthy
    end

    it "attributes is correct" do
      puts @entry
      expect(@entry[:description]).to be_truthy
      expect(@entry[:work_time]).to be_truthy
      expect(@entry[:tags]).to be_truthy
    end
  end
end
