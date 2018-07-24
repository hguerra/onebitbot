require_relative './../../spec_helper.rb'

describe LinkModule::CreateService do
  before do
    @company = create(:company)

    @link = FFaker::Internet.http_url
    @hashtags = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"
  end

  describe '#call' do
    it 'With valid params, receive success message' do
      create_service = LinkModule::CreateService.new({ 'link-original' => @link , 'hashtags-original' => @hashtags })

      response = create_service.call
      expect(response).to eq('Link salvo com sucesso')
    end

    it 'Raise an error without params' do
      expect { LinkModule::CreateService.new }.to raise_error(ArgumentError)
    end

    it 'Raise an error without link params' do
      create_service = LinkModule::CreateService.new({})

      response = create_service.call
      expect(response).to eq('Link Obrigatório')
    end

    it 'Raise an error without hashtags params' do
      create_service = LinkModule::CreateService.new({ 'link-original' => @link })

      response = create_service.call
      expect(response).to eq('Hashtag Obrigatória')
    end

    it 'With valid params, find a link in database' do
      create_service = LinkModule::CreateService.new({ 'link-original' => @link , 'hashtags-original' => @hashtags })

      create_service.call
      link = Link.last
      expect(link.link).to match(@link)
    end

    it 'With valid params, hashtags are created' do
      create_service = LinkModule::CreateService.new({ 'link-original' => @link , 'hashtags-original' => @hashtags })

      create_service.call
      expect(@hashtags.split(/[\s,]+/).first).to match(Hashtag.first.name)
      expect(@hashtags.split(/[\s,]+/).last).to match(Hashtag.last.name)
    end
  end
end
