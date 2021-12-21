set -xe

commit_hash=$1

cd /root/.vscode-server/bin
http_proxy=http://10.18.144.117:11087  https_proxy=http://10.18.144.117:11087  wget --tries=1 --connect-timeout=7 --dns-timeout=7 -nv -O vscode-server.tar.gz https://update.code.visualstudio.com/commit:$commit_hash/server-linux-x64/stable
tar xvf vscode-server.tar.gz
rm -rf $commit_hash
mv vscode-server-linux-x64 $commit_hash
rm vscode-server.tar.gz
cd -
