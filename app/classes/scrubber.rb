require 'html'

module Scrubber

  class Article
    include HTML
    attr_accessor :article

    def initialize article
    	@article = article
    end

    def validate
      @article.content = consolidate_content
      clean_content; clean_title; clean_url;
      @article
    end

    def consolidate_content
      @article.content && @article.summary ? return_longest : @article.content
    end

    def return_longest
      [@article.content, @article.summary].max_by(&:length)
    end

    def clean_content
      @article.content = Sanitize.clean(
        @article.content,
        attributes: HTML::WHITELIST[:attrs],
        elements: HTML::WHITELIST[:html],
        remove_contents: HTML::WHITELIST[:strip],
        transformers: HTML::BLACKLIST,
        output_encoding: 'utf-8')
    end

    def clean_title
      @article.title = trim_content @article.title
    end

    def clean_url
      @article.url = trim_content @article.url
    end

    def trim_content string
      string.strip
    end

  end

  class Feed
    attr_accessor :feedjira

    def initialize feedjira
      @feedjira = feedjira
    end

    def validate
      clean_title; find_url;
      @feedjira
    end

    def clean_title
      @feedjira.title = @feedjira.title.strip
    end

    def find_url
      if @feedjira.url
        @feedjira.url
      elsif @feedjira.feed_url =~ /feeds.feedburner.com/
        @feedjira.url = find_main_url_from_feedburner
      else
        logger.info "Feed URL is empty, XML feed found at: #{@feedjira.feed_url}"
      end
    end

    def find_main_url_from_feedburner
      page = Nokogiri::XML.parse(open(@feedjira.feed_url))
      namespace = set_namespace page
      page.xpath('//xmlns:link/@href', namespace).first.value
    end

    def set_namespace doc
      ns = doc.namespaces.first[0]
      v = doc.namespaces.first[1]
      {ns => v}
    end

  end

end