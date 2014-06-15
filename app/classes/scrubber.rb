require 'html'

class Scrubber
	include HTML

	attr_accessor :content

  def initialize content
  	@content = content
  end

  def validate_article
  	delegate = lambda { |attribute| "clean_#{attribute}".to_sym }
  	@content.each { |attribute| delegate.call(attribute) }
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

	def trim_content content
		content.strip
	end

end