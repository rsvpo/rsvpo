class SearchController < ApplicationController
  def index
    @activities = Activity.search(params)
    @categories =Category.all
    @skip_footer = true

    respond_to do |format|
      if params[:infinity]
        format.js { render :action => 'infinity' }
      elsif params[:loc]
        format.js { render :action => 'loc' }
      else
        format.js
      end
      format.html
    end
  end
end
