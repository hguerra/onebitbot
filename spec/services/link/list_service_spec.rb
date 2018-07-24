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
  end
end
