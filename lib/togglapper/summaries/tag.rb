module Togglapper
  module Summaries
    module Tag
      def summary_by_tags(*search_tags)
        entries = entries_by_tags(search_tags).map { |entry| entry_info(entry) }
        summary_time = entries.inject(0) { |sum, entry| sum = sum + entry[:work_time] }
        { entries: entries, summary_time: summary_time }
      end
    end
  end
end
