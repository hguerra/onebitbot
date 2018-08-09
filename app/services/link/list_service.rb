module LinkModule
  class ListService
    def initialize(params, action)
      @company = Company.last
      @action = action
      @query = params['query']
    end

    def call
      if @action == 'search_links'
        links = Link.search(@query).where(company: @company)
      elsif @action == 'search_links_by_hashtag'
        links = []

        @company.links.each do |link|
          link.hashtags.each do |hashtag|
            links << link if hashtag.name == @query
          end
        end
      else
        links = @company.links
      end

      return 'Nada encontrado' if links.nil? || links.count.zero?

      response = "*Links* \n\n"
      links.each do |f|
        response += "*#{f.id}* - "
        response += "*#{f.link}*\n"
        f.hashtags.each do |h|
          response += "_##{h.name}_ "
        end
        response += "\n\n"
      end

      response
    end
  end
end
