define :yum_repo, :action => 'add' do
  case params[:action].to_s
  when 'add'
    if params[:template]
      template "/etc/yum.repos.d/#{params[:name]}.repo" do
        source    params[:source]
        mode      params[:mode]
        variables params[:variables]
      end
    else
      cookbook_file "/etc/yum.repos.d/#{params[:name]}.repo" do
        source params[:source]
        mode   params[:mode]
      end
    end
  when 'remove'
    script "yum -y erase <#{params[:name]} packages>" do
      interpreter 'bash'
      code <<-SH
        packages=`repoquery --repoid=#{params[:name]} -a`
        if [ "0$packages" != "0" ]; then
          yum -y erase $packages
        fi
      SH
    end
    
    file "/etc/yum.repos.d/#{params[:name]}.repo" do
      action :delete
    end
  else
    raise "Invalid yum_repo action: #{params[:action]}"
  end
end
