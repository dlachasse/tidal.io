class OpmlParserWorker
  include Sidekiq::Worker

  def perform(user_id)
    OPMLParser.new user_id
  end
end