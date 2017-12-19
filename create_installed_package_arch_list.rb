#インストールパッケージの名前とアーキテクチャのリスト
def create_installed_package_arch_list
    # exec yum
    package_infos = `yum list installed`

    archlist = Hash.new()
    skiping = true
    package_infos.split(/\n/).each { | line |
        if skiping
            skiping = !/Installed Packages/.match(line)
            next
        end
        name_arch = line.split(' ')[0].split('.')
        archlist[name_arch[0]] = name_arch[1]
    }
    archlist
end

puts create_installed_package_arch_list
