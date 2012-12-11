#!/bin/awk
#-*- coding: utf-8 -*-

@include "utils.awk"

/:ref:/ {
    lpos = index($0, ":ref:")
    rpos = index($0, ">`") + 2
    
    label_lpos = index($0, "`") + 1
    label_rpos = index(substr($0, label_lpos), " ") + label_lpos
    
    anchor_lpos = index($0, "<") + 1
    anchor_rpos = rpos - 2

    print substr($0, 1, lpos-1) "[[#" \
        twiki_word(substr($0, anchor_lpos, anchor_rpos - anchor_lpos)) \
        "][" substr($0, label_lpos, label_rpos - label_lpos - 1) \
        "]]" substr($0, rpos)
    next
}

/`.*<.*>`_?/ {
    lpos = match($0, "[^`]`[^`]") + 2
    rpos = index(substr($0, lpos), "`") + lpos
    offset = (substr($0, rpos + 1, 1) == "_" ? 2 : 1);
    split(substr($0, lpos, rpos - lpos), links, "[<>]")
    print substr($0, 1, lpos-3)"[["links[2]"]["links[1]"]]" \
        substr($0, rpos+offset)
    next
}

{print $0}