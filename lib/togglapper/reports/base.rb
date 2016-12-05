module Togglapper
  module Reports
    module Base
      def report_by_summary(summary)
        entries_reports = []
        summary[:entries].each do |entry|
          entries_reports << "#{entry[:description]}/#{display_tags(entry[:tags])}: #{entry[:work_time]}s"
        end

        "合計: #{display_time(summary[:summary_time])}\n詳細:\n * #{entries_reports.join("\n * ")}"
      end


      private

      def display_tags(tags)
        return 'tagなし' if tags.nil? || tags.empty?
        tags.join(",")
      end

      def display_time(time_s)
        return '0.0h' if time_s == 0
        time_h = time_s.to_f/3600
        if time_h < 0.1
          "#{(time_h * 60).round(2)}m"
        else
          "#{time_h.round(2)}h"
        end
      end
    end
  end
end
