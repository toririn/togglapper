require 'togglv8'
require 'togglapper/search'
require 'togglapper/summary'
require 'togglapper/report'
require 'togglapper/params'
require "togglapper/version"

module Togglapper
  module ClientModule
    include Togglapper::Search
    include Togglapper::Params
    include Togglapper::Summary
    include Togglapper::Report

    URL       = "https://toggl.com/"
    TIMER_URL = "#{URL}app/timer"

    attr_accessor :client

    def initialize(api_token = ENV['TOGGL_API_TOKEN'])
      @client  = TogglV8::API.new(api_token)
    end

    def configure
      yield self
    end
  end
end
