class HomeController < ApplicationController
  def index
    @skip_header = true
    @skip_footer = true
  end
end
