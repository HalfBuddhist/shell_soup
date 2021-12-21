#!/bin/sh

USM_DIR=~/.ssh/usm
mkdir -p $USM_DIR

ARCHIVE=`awk '/^__ARCHIVE_BELOW__/ {print NR + 1; exit 0; }' $0`

# extract usmssh
tail -n+$ARCHIVE $0 > $USM_DIR/usmssh
# excute usmssh init
chmod +x $USM_DIR/usmssh
sh $USM_DIR/usmssh init $@

exit 0

__ARCHIVE_BELOW__
#!/bin/sh
# -rw-------
umask 0077

# basic settings
USM_HOSTNAME='__DASUSM__'

# configration directory
USM_DIR=~/.ssh/usm
mkdir -p $USM_DIR

USM_CONFIG=$USM_DIR/ssh_config
USM_PROFILE=$USM_DIR/bash_profile
USM_SSH_AGENT=$USM_DIR/start-ssh-agent.sh

help_exit() {
	cat <<EOF
usmssh - a utility for USM ssh gateway service using OpenSSH

examples:
	[root@~]# usmssh
	(usmssh)[root@~]# ssh fsl@192.168.50.1

EOF

	exit
}

install() {
	if [ $# -gt 0 ]; then
		USM_USER=`echo $1 |awk -F@ '{print $1}'`
		USM_HOST=`echo $1 |awk -F@ '{print $2}'`
	else
		echo
		echo  "please input USM ssh gateway service username (etc. admin)"
		read -p "USM username: " USM_USER

		echo
		echo "please input USM ssh gateway service address (etc. 192.168.50.129:60022)"
		read -p "USM hostname: " USM_HOST
		echo
	fi

	USM_IP=`echo $USM_HOST |awk -F: '{print $1}'`
	USM_PORT=`echo $USM_HOST |awk -F: '{print $2}'`
	[ -n "$USM_PORT" ] || USM_PORT='60022'

	# TODO: try to connect to USM server
	touch /tmp/.config.$$ 2>/dev/null
	unalias -a 2>/dev/null
	msg=`ssh -F /tmp/.config.$$ -o port=$USM_PORT $USM_USER@$USM_IP "exit" 2>&1`
	rm -f /tmp/.config.$$ 2>&1 >/dev/null
	echo "$msg" |grep -q "GATE" 2>&1 >/dev/null
	if [ $? -ne 0 ]; then
		echo
		echo $msg
		echo
		echo
		echo "verify  $USM_USER@$USM_IP:$USM_PORT ..... [ ERR ]"
		exit
	fi

	# check if -W is supported
	PROXY_COMMAND="ssh -F $USM_CONFIG -q $USM_HOSTNAME -W %h:%p"
	ssh -W 2>&1 |grep -q "illegal option" 2>&1 >/dev/null
	if [ $? -eq 0 ]; then
		PROXY_COMMAND="ssh -F $USM_CONFIG -q $USM_HOSTNAME usm-ProxyCommand-nc --target %h:%p"
	fi

	# install ~/.ssh/usm/config
	cat > $USM_CONFIG <<EOF
# `date +"%F %T"`

Host $USM_HOSTNAME
	User $USM_USER
	Hostname $USM_IP
	Port $USM_PORT

Host 1* 2* 3* 4* 5* 6* 7* 8* 9*
	ProxyCommand $PROXY_COMMAND
	ForwardAgent yes

Host a* b* c* d* e* f* h* i* j* k* l* m* n* o* p* q* r* s* t* u* v* w* x* y* z*
	ProxyCommand $PROXY_COMMAND
	ForwardAgent yes

Host A* B* C* D* E* F* H* I* J* K* L* M* N* O* P* Q* R* S* T* U* V* W* X* Y* Z*
	ProxyCommand $PROXY_COMMAND
	ForwardAgent yes
EOF

	# install ssh-agent autorun script
	cat > $USM_SSH_AGENT <<EOF
#!/bin/sh
SSH_ENV="\$HOME/.ssh/usm/environment"
start_agent() {
	echo "Initialising new SSH agent..."
	/usr/bin/ssh-agent | sed 's/^echo/#echo/' > "\${SSH_ENV}"
	echo succeeded
	chmod 600 "\${SSH_ENV}"
	. "\${SSH_ENV}" > /dev/null
	/usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "\${SSH_ENV}" ]; then
	. "\${SSH_ENV}" > /dev/null
	#ps \${SSH_AGENT_PID} doesn't work under cywgin
	ps -ef | grep \${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
	start_agent;
}
else
	start_agent;
fi
EOF

	# install scp/sftp wrapper
	SSH_WRAPPER=$USM_DIR/ssh.pl
	cat > $SSH_WRAPPER <<EOF
#!/usr/bin/perl
exec '/usr/bin/ssh', map {\$_ eq '-oForwardAgent=no' ? () : \$_ eq '-oForwardAgent no' ? () : \$_} @ARGV;
EOF
	#
	chmod +x $SSH_WRAPPER || echo "install $SSH_WRAPPER ... [ ERR ]"

	# install usmssh path
	grep "PATH" ~/.bashrc 2>/dev/null |grep -q "usm" 2>/dev/null
	if [ ! $? -eq 0 ]; then
		echo 'export PATH=${PATH}:'"$USM_DIR" >> ~/.bashrc
	fi
	grep "PATH" ~/.bash_profile 2>/dev/null |grep -q "usm" 2>/dev/null
	if [ ! $? -eq 0 ]; then
		echo 'export PATH=${PATH}:'"$USM_DIR" >> ~/.bash_profile
	fi

	# install ~/.ssh/usm/profile
	cat > $USM_PROFILE <<EOF
# source personal bashrc
[ -f ~/.bashrc ] && source ~/.bashrc

# start ssh-agent
[ -f "$USM_SSH_AGENT" ] && source $USM_SSH_AGENT

# alias
alias ssh='ssh -F $USM_CONFIG'
alias scp='scp -F $USM_CONFIG -S $SSH_WRAPPER'
alias sftp='sftp -F $USM_CONFIG -S $SSH_WRAPPER'

# exports
export PS1='\[\e[0;32m(usmssh)\[\e[0m\]'\$PS1
EOF

	# show help
	cat <<EOF

install 'usmssh' successfully. please 'exit' and login again.

usmssh - a utility for USM ssh gateway service using OpenSSH

examples:
	[root@~]# sh ~/.ssh/usm/usmssh
	(usmssh)[root@~]# ssh 192.168.50.1

EOF
}

shell() {
	bash --init-file $USM_PROFILE
	exit
}

case $1 in
	init)
	shift
	install $@
	;;
	-h|--help|help)
	help_exit
	;;
	*)
	# check if have our usmssh profile
	[ -f "$USM_PROFILE" ] || help_exit

	# enter usmssh
	shell
	;;
esac

