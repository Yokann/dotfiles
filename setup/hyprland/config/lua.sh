cat > /tmp/luarock.sh <<'EOF'
if [ command luarock --version >/dev/null 2>&1 ]; then
    eval "$(luarocks path --bin)"
fi
EOF

sudo mv /tmp/luarock.sh /etc/profile.d/luarock.sh
