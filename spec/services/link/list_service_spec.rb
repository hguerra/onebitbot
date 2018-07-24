require_relative './../../spec_helper.rb'

describe LinkModule::ListService do
  before do
    @company = create(:company)
  end

  describe '#call' do
    it 'Raise an error without params' do
      expect { LinkModule::ListService.new }.to raise_error(ArgumentError)
    end

    it 'No links were found' do
      list_service = LinkModule::ListService.new({}, 'list')

      response = list_service.call
      expect(response).to eq('Nada encontrado')
    end

    it 'With two links, find links' do
      list_service = LinkModule::ListService.new({}, 'list')

      link1 = create(:link, company: @company)
      link2 = create(:link, company: @company)

      response = list_service.call

      expect(response).to eq(link1.link)
      expect(response).to eq(link2.link)
    end

    it 'With invalid hashtag, return dont find message' do
      list_service = LinkModule::ListService.new({ 'query': '' }, 'search_by_hashtag')

      response = list_service.call
      expect(response).to eq('Nada encontrado')
    end

    it 'With valid hashtag, find link in response' do
      link = create(:link, company: @company)
      hashtag = create(:hashtag, company: @company)
      create(:link_hashtag, link: link, hashtag: hashtag)

      list_service = LinkModule::ListService.new({ 'query': hashtag.name }, 'search_by_hashtag')

      response = list_service.call
      expect(response).to eq(link.link)
    end
  end
end
