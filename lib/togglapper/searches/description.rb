module Togglapper
  module Searches
    module Description
      def entries_by_description(description)
        entries.select { |entry| entry["description"] == description }
      end
    end
  end
end
