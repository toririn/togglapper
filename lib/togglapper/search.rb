require 'togglapper/searches/now'
require 'togglapper/searches/description'
require 'togglapper/searches/tag'
require 'togglapper/searches/date'

module Togglapper
  module Search
    include Searches::Now
    include Searches::Description
    include Searches::Tag
    include Searches::Date
  end
end
