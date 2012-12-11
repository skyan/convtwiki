#!/bin/awk
#-*- coding: utf-8 -*-

@include "utils.awk"

/\.\. code-block:: c++/ {
    ori_indent = indent_length($0);
    if (getline <=0) {
        next
    }
    print "%CODE{\"cpp\"}%\n"
    indent = indent_length($0);
    while (indent > ori_indent || length($0) == 0 ||
           (indent == ori_indent && length($0) == indent)) {
        print $0
        if (getline <=0) {
            break;
        }
        indent = indent_length($0);
    }
    print "\n%ENDCODE%"
}

/^[ ]*\- / {
    pos = index($0, "-")
    print "   * "substr($0, pos+1)
    next
}

/^[ ]*#./ {
    pos = index($0, ".")
    print "   1"substr($0, pos+1)
    next
}

/\.\. _.*:/ {
    begin = index($0, "_") + 1
    end = index($0, ":")
    print "#"twiki_word(substr($0, begin, end - begin))
    next
}


/\.\. warning::/ {
    pos = index($0, "::") + 2
    print "%RED% 注意："substr($0, pos, length($0) - pos + 1)"%ENDCOLOR%"
    next
}

/^(定义)|(优点)|(缺点)|(结论)/ {
    print "__" $0 "__\n"
    next
}

/\.\. note::/ {
    pos = index($0, "::") + 2
    print "%BLUE% 注："substr($0, pos, length($0) - pos + 1)"%ENDCOLOR%"
    next
}

/^译者.*笔记/ {
    #hack: ignore following text
    nextfile
}

{print}

