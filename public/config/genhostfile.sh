#!/bin/bash
# This file generates hostfile from hosts
(for i in `cat /etc/hosts`;do echo $i;done)|grep ^node>/public/hostfile
