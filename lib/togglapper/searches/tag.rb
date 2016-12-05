require 'togglapper/searches/base'
module Togglapper
  module Searches
    module Tag
      include Togglapper::Searches::Base

      def entries_by_tags(*tags)
        entries_by_tags_for(self.entries, tags)
      end

      def entries_by_tags_for(entries, *tags)
        entries.select do |entry|
          tags.flatten.map(&:to_s).all? do |tag|
            entry["tags"] && entry["tags"].include?(tag)
          end
        end
      end
    end
  end
end
