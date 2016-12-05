module Togglapper
  module Searches
    module Now
      def entries(refresh: false)
        if refresh
          @entries = toggl_client.my_time_entries
        else
          @entries ||= toggl_client.my_time_entries
        end
      end

      def day_entries(day = Time.now.to_date)
        entries.select do |entry|
          start_date = Time.parse(entry["start"]).getlocal("+09:00").to_date
          start_date == day
        end
      end

      def entries_by_tags(*tags)
        entries.select do |entry|
          tags.map(&:to_s).all? do |tag|
            entry["tags"] && entry["tags"].include?(tag)
          end
        end
      end

      def latest_entry
        entries.sort_by{ |entry| entry["start"] }.last
      end

      def working_entry
        if latest_entry["stop"].nil?
          latest_entry
        end
      end
    end
  end
end
