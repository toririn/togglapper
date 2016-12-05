module Togglapper
  module Searches
    module Date

      def entries_by_date(target_date = Time.now.to_date)
        entries.select do |entry|
          start_date = Time.parse(entry["start"]).getlocal("+09:00").to_date
          start_date_in_target_date?(start_date, target_date)
        end
      end

      def entries_by_this_week
        today       = Time.now.to_date
        this_monday = today - (today.wday - 1)
        entries.select do |entry|
          start_date = Time.parse(entry["start"]).getlocal("+09:00").to_date
          start_date_in_target_date?(start_date, this_monday..today)
        end
      end

      def entries_by_this_month
        begin_month_day = Date.new(Time.now.year, Time.now.month, 1)
        end_month_day   = Date.new(Time.now.year, Time.now.month, -1)
        entries.select do |entry|
          start_date = Time.parse(entry["start"]).getlocal("+09:00").to_date
          start_date_in_target_date?(start_date, begin_month_day..end_month_day)
        end
      end

      alias_method :entries_by_today, :entries_by_date

      private

      def start_date_in_target_date?(start_date, target_date)
        case target_date.class.to_s
        when "Date"
          start_date == target_date
        when "Range", "Array"
          target_date.include?(start_date)
        when "String"
          start_date == Date.parse(target_date) rescue raise "invalid target_date format: #{target_date}. format is yyyy/mm/dd"
        when "Time"
          start_date == target_date.to_date
        else
          raise "invalid date format: #{target_date.class}. format is Date, Range, String, Array, Time"
        end
      end
    end
  end
end
