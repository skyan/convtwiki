#!/bin/awk
#-*- coding: utf-8 -*-

/\.\. tip::/ {
    if (getline <=0) {
        next
    }
    print $0
    print "\n%TWISTY{mode=\"div\" \
showlink=\"详细：\" hidelink=\"收回\" \
showimgleft=\"%ICONURLPATH{toggleopen}%\" \
hideimgleft=\"%ICONURLPATH{toggleclose}%\" \
}%";
    u = $0 !~ /^[1-9]/
    while (u) {
        if (getline <=0) {
            print "\n%ENDTWISTY%"
            next
            break;
        }
        u = $0 !~ /^[0-9]/
        if (u) {
            print $0
        }
    }
    print "\n%ENDTWISTY%"
}

{print $0}

