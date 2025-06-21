function __jj.init
    function __jj.create_abbr -d "Create Git plugin abbreviation"
        set -l name $argv[1]
        set -l body $argv[2..-1]

        # TODO: global scope abbr will be default in fish 3.6.0
        abbr -a -g $name $body
    end

    # Provide a smooth transition from universal to global abbreviations by
    # deleting the old univeral ones.  Can be removed after fish 3.6 is in
    # wide-spread use, i.e. 2024.  __jj.destroy should also be removed
    # at the same time.
    if set -q __jj_plugin_initialized
        __jj.destroy
    end

    # jj abbreviations
    __jj.create_abbr j    jj
    __jj.create_abbr jb   jj bookmark
    __jj.create_abbr jbc  jj bookmark create
    __jj.create_abbr jbd  jj bookmark delete
    __jj.create_abbr jbl  jj bookmark list
    __jj.create_abbr jbm  jj bookmark move
    __jj.create_abbr jbs  jj bookmark set
    __jj.create_abbr jbn  jj bookmark set -r@-
    __jj.create_abbr jcm  jj commit -m
    __jj.create_abbr jd   jj diff
    __jj.create_abbr je   jj edit
    __jj.create_abbr jg   jj git
    __jj.create_abbr jge  jj git export
    __jj.create_abbr jgf  jj git fetch
    __jj.create_abbr jgim jj git import
    __jj.create_abbr jgi  jj git init --colocate
    __jj.create_abbr jgp  jj git push
    __jj.create_abbr jgr  jj git remote
    __jj.create_abbr jn   jj new
    __jj.create_abbr jnm  jj new -m
    __jj.create_abbr jst  jj st
    __jj.create_abbr jsq  jj squash --into @-

    # Cleanup declared functions
    functions -e __jj.create_abbr
end
