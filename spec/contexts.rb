shared_context 'With create client' do
  before :all do
    @client = Togglapper::Client.new(ENV['TOGGL_API_TOKEN_TEST'])
  end
end
