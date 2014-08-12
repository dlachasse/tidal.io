class PagesController < ApplicationController
  skip_before_filter :restrict_access

  def home
  end

end