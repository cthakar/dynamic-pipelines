#!/bin/bash

echo "--------------------Creating codefresh pipelines-----------------------"

#declare -a existing
#declare -a new
#declare -a final

existing=`codefresh get pipelines | awk '{print $1}' | grep -v "NAME" | grep "dynamic-pipelines" | cut -d '/' -f 2`
new=`ls ./projects/services/`
final=$(echo ${new[@]} ${existing[@]} | sed 's/ /\n/g' | sort | uniq -d | xargs echo ${new[@]} | sed 's/ /\n/g' | sort | uniq -u)



for svc in $final
do
    #echo "codefresh create pipeline -f ./projects/services/$svc/pipeline-spec.yml"
    codefresh create pipeline -f ./projects/services/$svc/pipeline-spec.yml
done
