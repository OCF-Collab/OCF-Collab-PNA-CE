require 'spec_helper'

RSpec.describe 'Competencies' do
  let(:authenticator) { double(OcfCollabJwtAuthenticator) }
  let(:id) { Faker::Internet.url }
  let(:token) { Faker::Lorem.characters }

  let(:fetch_competency) do
    get "/competencies/asset_file?id=#{id}",
        headers: { Authorization: "Bearer #{token}" }
  end

  before do
    expect(OcfCollabJwtAuthenticator).to receive(:new)
      .with(token:)
      .and_return(authenticator)
  end

  context 'invalid token' do
    before do
      expect(authenticator).to receive(:token_data).and_raise(JWT::DecodeError)
    end

    it 'returns 401' do
      fetch_competency
      expect(response.status).to eq(401)
    end
  end

  context 'valid token' do
    let(:body) { Faker::Json.shallow_json }
    let(:content_type) { Faker::Lorem.word }
    let(:headers) { { 'Content-Type' => content_type } }

    before do
      expect(authenticator).to receive(:token_data)
        .and_return(Faker::Lorem.characters)

      stub_request(:get, id).to_return(body:, headers:, status: 200)
    end

    it 'fetches competency from provider network' do
      fetch_competency
      expect(response.body).to eq(body)
      expect(response.headers['Content-Type']).to eq(content_type)
      expect(response.status).to eq(200)
    end
  end
end
