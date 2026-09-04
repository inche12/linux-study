#!/bin/sh
echo '$#: ' $#
echo '$@: ' $@
echo '$*: ' $*
echo
echo '$1 $2 $9 $10 are: ' $1 $2 $9 $10
echo
shift
echo '$#: ' $#
echo '$@: ' $@
echo '$*: ' $*
echo
echo '$1 $2 $9 are: ' $1 $2 $9
shift 2
echo '$#: ' $#
echo '$@: ' $@
echo '$*: ' $*
echo
echo '$1 $2 $9 are: ' $1 $2 $9
echo '${10}: ' ${10}
$ ./argtest.sh a b c d e f g h i j k l m n
$#: 14
$@: a b c d e f g h i j k l m n
$*: a b c d e f g h i j k l m n
$1 $2 $9 $10 are: a b i a0
$#: 13
$@: b c d e f g h i j k l m n
$*: b c d e f g h i j k l m n
$1 $2 $9 are: b c j
$#: 11
$@: d e f g h i j k l m n
$*: d e f g h i j k l m n
$1 $2 $9 are: del
${10}: m
