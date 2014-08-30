class RuleInstancesController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    @rule_instances = RuleInstance.occurrences_between(Date.today - 1.year,Date.today + 1.year)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rule_instances.to_json(:methods => [:color]) }
    end
  end
end