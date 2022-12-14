class CompetencyFetcher
  class NotFoundError < StandardError; end

  attr_reader :id

  alias :competency_url :id

  def initialize(id:)
    @id = id
  end

  def body
    response.body
  end

  def content_type
    response.headers.fetch("content-type")
  end

  private

  def response
    @response ||= Faraday.get(competency_url).tap do |response|
      raise NotFoundError unless response.success?
    end
  end
end
