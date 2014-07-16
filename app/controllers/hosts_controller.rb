class HostsController < InheritedResources::Base
  def index
    @hosts = @merchant.hosts
  end
end
