# define :tuleap_dependencies_for, :only_if => [] do
#   php_base = node['tuleap']['php_base']
#   
#   node['tuleap'][params[:name]]['dependencies'].each do |name|
#     package eval("\"#{name}\"") do
#       action params[:action]
#       params[:only_if].each do |condition|
#         only_if condition
#       end
#     end
#   end
# end
