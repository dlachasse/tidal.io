require 'html'

module Scrubber

  class Article
    include HTML

    def initialize article
    	@article = article
      @article.content = consolidate_content
    end

    def validate
      clean_content; clean_title; clean_permalink; fix_relative_refs;
      @article
    end

    def body
      @article.content
    end

    def consolidate_content
      return @article.content unless @article.respond_to?(:content)
      @article.content = "" if @article.content.nil?
      @article.summary = "" if @article.summary.nil?
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
        output_encoding: 'utf-8').strip
    end

    def clean_title
      @article.title = trim_content @article.title
    end

    def clean_permalink
      @article.url = trim_content @article.url
    end

    def trim_content string
      string.strip unless string.nil?
    end

    def prepend_permalink
      Feed.find(@article.feed_id).select(:url)
    end

    def fix_relative_refs
      if /(?<protocol>\w*)(?::\/\/)(?<base_url>[^\/\r\n]+)(?:\/[^\r\n]*)?/ =~ @article.url
        base_url = protocol + "://" + base_url
        doc = Nokogiri::HTML.fragment(@article.content)
        doc = relative_links(doc, base_url)

        @article.content = doc.to_html
      elsif @article.url =~ /^(\/\/|\/)/
        prepend_permalink + @article.url
        fix_relative_refs
      end
    end

    def relative_links(nokogiri_doc, base_url)
      links = {"a" => "href", "img" => "src"}
      links.each_pair do |elem, attribute|
        nokogiri_doc.css(elem).each do |link|
          if link.attributes[attribute].respond_to?(:value) && link.attributes[attribute].value =~ /\A\//
            link.attributes[attribute].value = base_url + link.attributes[attribute].value
          end
        end
      end
      nokogiri_doc
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
      if @feedjira.title
        @feedjira.title = @feedjira.title.strip
      end
    end

    def find_url
      if @feedjira.url
        @feedjira.url
      elsif @feedjira.feed_url =~ /feeds.feedburner.com/
        @feedjira.url = find_main_url_from_feedburner
      else
        Rails.logger.info "Feed URL is empty, XML feed found at: #{@feedjira.feed_url}"
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