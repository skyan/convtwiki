#!/bin/awk
#-*- coding: utf-8 -*-

function indent_length(line) {
    split(line, chars, "");
    c = 0;
    for (i = 1; i <=length(chars); ++i) {
        if (chars[i] == " ") {
            ++c;
        } else {
            break;
        }
    }
    return c;
}

function join(array, start, end, sep, result, i){
    if (sep == "")
        sep = " "
    else if (sep == SUBSEP) # magic value
        sep = ""
    result = array[start]
    for (i = start + 1; i <= end; i++)
        result = result sep array[i]
    return result
}

function twiki_word(word) {
    split(word, chars, "")
    chars[1] = toupper(chars[1])
    for (i = 1; i <=length(chars); ++i) {
        if (chars[i] == "-" || chars[i] == "_") {
            chars[i] = "A"
        }
    }
    chars[length(chars)] = toupper(chars[length(chars)])
    return join(chars, 1, length(chars), SUBSEP)
}

