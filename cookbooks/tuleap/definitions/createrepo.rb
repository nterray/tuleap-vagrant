define :createrepo, :user => 'root' do
  script "createrepo #{params[:name]}" do
    interpreter 'bash'
    user params[:user]
    cwd params[:path]
    code <<-SH
      createrepo --update .
      chmod o+rx .
      parent_dir=`dirname `
      while [ $parent_dir != '/' ]; do
        chmod o+x $parent_dir
        parent_dir=`dirname $parent_dir`
      done
    SH
    not_if "test -d #{params[:path]}/repodata"
  end
end
