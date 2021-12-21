#!/usr/bin/expect
if { $argc != 1 } {
    send_user "Usage: id or ip\n"
    exit
}
#set USER DEMO_USER     # replace DEMO_USER with your username
#set PASSWD DEMO_PASSWD # replace DEMO_PASSWD with your password
set USER liuqingwei
set PASSWD Cx_252019
set IP [lindex $argv 0]

catch { spawn ssh $USER@devops.ainnovation.com -p58319 -o ServerAliveInterval=10 -o TCPKeepAlive=yes }
expect {
    "password:"
    { send "$PASSWD\n" }
}
expect {
    ">"
    { send "$IP\n" }
}
interact