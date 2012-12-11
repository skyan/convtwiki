#!/bin/awk
#-*- coding: utf-8 -*-

{
    pre = $0
    while (getline cur > 0) {
        if (cur ~ /^\-+$/) {
            print "---++ "pre
        } else if (cur ~ /^~+/) {
            print "---+++ "pre
        } else if (cur ~ /^\^+/) {
            print "---+++!! "pre
        } else if (pre !~ /^[\-~\^]+/){
            print pre
        }
        pre = cur
    }
    print pre
}
