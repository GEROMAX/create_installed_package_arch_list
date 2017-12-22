#インストールパッケージの名前とアーキテクチャのリスト
def create_installed_package_arch_list
  # exec yum
  package_infos = `yum list installed`

  archlist = Hash.new()
  skiping = true
  package_infos.split(/\n/).each do | line |
    if skiping
      skiping = !/Installed Packages/.match(line)
      next
    end
    name_arch = line.split(' ')[0].split('.')
    archlist[name_arch[0]] = name_arch[1]
  end
  archlist
end
#インストール済みパッケージの名前、アーキテクチャ、エポック取得
def get_installed_package_arch_epoch
  details = Hash.new
  #yumよりrepoqueryのほうが成形しやすい
  command_results = `repoquery --all --pkgnarrow=installed --qf="%{name}.%{arch}.%{epoch}"`
  command_results.split(/\n/).each do |line|
    detail = line.split('.')
    details[detail[0]] = detail
  end
  details
end

puts get_installed_package_arch_epoch
