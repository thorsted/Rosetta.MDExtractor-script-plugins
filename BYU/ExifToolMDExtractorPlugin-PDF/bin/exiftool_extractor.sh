#!/bin/sh
outFile="out"
now=`awk -v min=5 -v max=10 'BEGIN{srand(); print int(1+rand()*(999999-min+1))}'`
outFile='out_'$now'.xml'

exiftool -X $1 > $outFile

pathToXsl=`echo $0 | sed -e 's,bin/exiftool_extractor.sh,PLUGIN-INF/transformer.xsl,g'`

output=`xsltproc $pathToXsl $outFile`

retval=$status
echo $output
rm $outFile

exit $retval