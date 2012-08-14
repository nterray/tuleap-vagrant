define :tuleap_dependencies_for do
  php_base = node['tuleap']['php_base']
  
  node['tuleap'][params[:name]]['dependencies'].each do |name|
    package eval("\"#{name}\"") do
      action params[:action]
    end
  end
end
