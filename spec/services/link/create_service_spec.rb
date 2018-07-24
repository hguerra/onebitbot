require_relative './../../spec_helper.rb'

describe Link::CreateService do
  before do
    @company = create(:company)
    @link = FFaker::Internet.http_url
  end

  describe '#call' do
    it 'With valid params, receive success message' do
      create_service = Link::CreateService.new({'link-original' => @link})

      response = create_service.call
      expected(response).to eq('Link salvo com sucesso')
    end
  end
end
