require 'html'

class Scrubber
	include HTML

	attr_accessor :content

  def initialize content
  	@content = content
  end

  def validate_feed
  	clean_title
  end

  def validate_article
  	@content.content = consolidate_content
  	clean_content; clean_title; clean_url;
  end

  def consolidate_content
  	if @content.content && @content.summary
  		return_longest
  	else
  		@content.content
  	end
  end

  def return_longest
  	[@content.content, @content.summary].max_by(&:length)
  end

  def clean_content
	  @content.content = Sanitize.clean(
		  @content.content,
		  attributes: HTML::WHITELIST[:attrs],
		  elements: HTML::WHITELIST[:html],
		  remove_contents: HTML::WHITELIST[:strip],
		  output_encoding: 'utf-8')
	end

	def clean_title
		@content.title = trim_content @content.title
	end

	def clean_url
		@content.url = trim_content @content.url
	end

	def trim_content string
		string.strip
	end

	def method_missing(meth, *args, &block)
    puts "Unsuccesfully tried to run method: #{meth}"
  end

end