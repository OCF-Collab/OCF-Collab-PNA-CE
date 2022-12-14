class CompetenciesController < ApplicationController
  def asset_file
    fetcher = CompetencyFetcher.new(id: params.require(:id))
    send_data fetcher.body, disposition: :inline, type: fetcher.content_type
  end
end
