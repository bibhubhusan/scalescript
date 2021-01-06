#!/bin/sh

my_lb_name=`echo Scaletestlb`

if [ -n "$my_lb_name" ]
        then
                my_ip_addr=`ifconfig eth1 | grep "inet " | sed 's/^[ ]*//g' | awk {'print $2'}`
                my_lb_id=`slcli --format raw loadbal list | grep $my_lb_name | awk {'print $1'}`
                slcli loadbal member-add --public -m "$my_ip_addr" $my_lb_id
                echo "**************\n" >/var/log/scaletestlb.log
                slcli loadbal detail $my_lb_id >>/var/log/scaletestlb.log
        else
                echo "Please provide Load Balancer Name as Argument\n" >>/var/log/scaletestlb.log
fi
