require 'togglapper/summaries/tag'
require 'togglapper/summaries/date'
module Togglapper
  module Summary
    include Togglapper::Summaries::Tag
    include Togglapper::Summaries::Date
  end
end
