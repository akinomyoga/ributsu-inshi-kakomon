#!/bin/bash

grep '%' *.tex|grep -v 'tex\:[ \t]*%\|%$'
