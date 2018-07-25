require_relative './../../spec_helper.rb'

describe LinkModule::RemoveService do
  before do
    @company = create(:company)
  end

  describe '#call' do
    it 'With valid ID, remove Link' do
      link = create(:link, company: @company)
      remove_service = LinkModule::RemoveService.new({ 'id' => link.id })
      response = remove_service.call

      expect(response).to match('Link removido com sucesso')
    end

    it 'With invalid ID, receive error message' do
      remove_service = LinkModule::RemoveService.new({ 'id' => rand(1..9999) })
      response = remove_service.call

      expect(response).to match('Link inválido, verifique o Id')
    end

    it 'With valid ID, remove Link from database' do
      link = create(:link, company: @company)
      remove_service = LinkModule::RemoveService.new({ 'id' => link.id })

      expect(Link.all.count).to eq(1)

      remove_service.call

      expect(Link.all.count).to eq(0)
    end
  end
end
