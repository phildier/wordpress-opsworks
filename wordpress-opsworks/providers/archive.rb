use_inline_resources

action :create do
	dest = new_resource.name
	source = new_resource.source
	create_dir = new_resource.create_dir

    bash "unarchive #{source} #{dest}" do
        cwd dest
        code <<-EOH
        tar -xf #{source} --no-same-owner
        md5sum `tar tf #{source} | grep -ve '/$'` > .md5sum
        EOH
        not_if "cd #{dest} && md5sum -c #{dest}/.md5sum"
    end

end

action :delete do
	raise "not implemented"
end
