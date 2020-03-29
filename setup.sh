#!/bin/bash
shell_dir=$(dirname $(readlink -f "$0"))
base_dir=$shell_dir
config_dir=$base_dir/config
link_dir=$base_dir/link

#软连接
#$1:目标
#$2:链接名
link(){
    e_info "linking" $1
    ln -sf $1 $2
}

#信息提示
e_info(){
    echo -e " \033[1;34m➜\033[0m  $@";
}

#如果存在这个文件就删除
#$1:文件路径
rm_ifexists(){
    if [ -e $1 ]
    then
        rm $1
    fi
}

handle_link(){
    local files=`ls -A $link_dir`
    for file in ${files[@]}
    do
        link $link_dir/$file ~/$file
    done
}

handle_config(){
    local files=`ls -A $config_dir`
    for file in ${files[@]}
    do
        link $config_dir/$file ~/.config/$file
        rm_ifexists ~/.$file
    done
}

handle_link
handle_config