module LinkModule
  class CreateService
    def initialize(params)
      @company = Company.last
      @link = params['link-original']
      @hashtags = params['hashtags-original']
    end

    def call
      return 'Link Obrigatório' unless @link
      return 'Hashtag Obrigatória' unless @hashtags

      Link.transaction do
        link = Link.create(link: @link)
        @hashtags.split(/[\s,]+/).each do |hashtag|
          link.hashtags << Hashtag.create(name: hashtag)
        end
      end

      'Link salvo com sucesso'
    end
  end
end
