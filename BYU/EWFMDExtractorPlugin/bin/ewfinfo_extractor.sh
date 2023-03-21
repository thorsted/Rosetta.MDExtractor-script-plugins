#!/bin/sh

# tool output file
outFile="out"
now=`awk -v min=5 -v max=10 'BEGIN{srand(); print int(1+rand()*(999999-min+1))}'`
outFile='out_'$now'.xml'
ewfinfo -f dfxml $1 > $outFile

tool_agent=`ewfinfo -V | sed 1q`
pathToXsl=`echo $0 | sed -e 's,bin/ewfinfo_extractor.sh,PLUGIN-INF/transformer.xsl,g'`

output=`xsltproc $pathToXsl $outFile`
mimeType=`application/encase`
output=`echo $output | sed -e 's,</mdExtractor>,,g'`
output=$output'<agent>'$tool_agent'</agent><mimeType>'$mimeType'</mimeType></mdExtractor>'

retval=$status
echo $output
rm $outFile

exit $retval