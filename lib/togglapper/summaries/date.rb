module Togglapper
  module Summaries
    module Date
      def dailyreport
        today_entry_reports
      end

      def daily_by_tags(*search_tags)
        day_entries = entry_info(entries_by_today)
        day_entries.select do |entry|
          entry[:tags] && entry[:tags].any? { |tag| search_tags.include?(tag) }
        end
      end

      def daily_by_description(description)
        day_entries = entry_info(entries_by_today)
        day_entries.select do |entry|
          entry[:description] && entryentry[:description] =~ description
        end
      end

      private

      def today_entry_reports
        reports = []
        day_entries.each do |entry|
          reports << entry_info(entry)
        end

        report_group =
          reports.group_by do |report|
            report["description"]
          end

        today_reports =
          report_group.map do |discription, entrys|
            sum_time = entrys.inject(0){|sum, entry| sum + entry["work_time"] }
            "#{discription} \(#{(sum_time/60).round(1)}.h\)"
          end
        today_reports.join("\n")
      end
    end
  end
end
