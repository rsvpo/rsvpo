class HostsController < InheritedResources::Base
  def index
    @hosts = @merchant.hosts
  end
  
  def create
    @merchant = current_merchant
    @host = @merchant.hosts.build(safe_params)
    if @host.save
      redirect_to hosts_path, :notice => "已加入主持"
    else
      render :action => 'new'
    end
  end
  
  def update
    @host = Host.find(params[:id])
    if @host.update_attributes(safe_params)
      redirect_to hosts_path, :notice  => "已更新主持"
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @host = Host.find(params[:id])
    @host.destroy
    redirect_to hosts_path, :notice => "已刪除主持"
  end
  
  private

  def safe_params
    host_attributes = [
      :title,
      :job,
      :photo,
      :description
    ]
    params.require(:host).permit(*host_attributes)
  end
end
