module LinkModule
  class RemoveService
    def initialize(params)
      @company = Company.last
      @params = params
      @id = params['id']
    end

    def call
      link = @company.links.where(id: @id).last
      return 'Link inválido, verifique o Id' if link.nil?

      Link.transaction do
        link.hashtags.each do |h|
          h.delete if h.links.count <= 1
        end

        link.delete

        'Link removido com sucesso'
      end
    end
  end
end
