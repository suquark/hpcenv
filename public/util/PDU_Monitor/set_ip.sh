#!/bin/sh
echo $1
ip addr change 168.0.0.2/16 dev $1 valid_lft forever
