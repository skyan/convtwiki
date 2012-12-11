#!/bin/bash

awk -f $1 | awk -f convtwiki2.awk | awk -f convtwiki3.awk | awk -f convtwiki3.awk
