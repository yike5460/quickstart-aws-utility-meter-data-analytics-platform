#!/usr/bin/env bash

set -e

BUCKETS=`aws s3 ls`



for bucket in $BUCKETS
do

  if  [[ $bucket == smartmeterbj-workload-* ]] || [[ $bucket == aws-glue-*-cn-north-1 ]] ;
  then
      echo "Deleting bucket: $bucket"
      {
        sh delete-buckets.sh $bucket
      } || {
        echo "Error deleting bucket: $bucket"
      }
  fi

done

echo "Deleting stack smartmeter"
aws cloudformation delete-stack --stack-name smartmeterbj
