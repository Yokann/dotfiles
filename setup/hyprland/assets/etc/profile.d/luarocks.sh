if [ command luarock --version >/dev/null 2>&1 ]; then
    eval "$(luarocks path --bin)"
fi
