require "spec_helper"

describe Togglapper do
  include_context 'With create client'
  describe "#report_by_summary" do
    before(:all) { @report = @client.report_by_summary(@client.summary_by_tags("#2661")) }
    it "return entries" do
      puts @report
      expect(@report).to be_truthy
    end
  end
end
