class SearchController < ApplicationController
  def index
    if params[:query].present?
      @activities = Activity.search(params)
    else
      @activities = Activity.active.category(params[:category]).page(params[:infinity]).per(12)
    end
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
