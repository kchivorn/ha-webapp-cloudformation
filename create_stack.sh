#!/usr/bin/env bash

# set arguments name
stack_name=$1
template_body=$2
parameters=$3
region=us-east-1

# check parameters

if [ -z $stack_name ] || [ -z $template_body ] || [ -z $parameters ]
then
  echo "\n Missing parameters \n"
  echo "Usage: create_stack <stack_name> <template_body> <parameters>\n"
fi

# validate template and parameters
aws cloudformation validate-template --template-body file://$template_body > /dev/null 2>&1
if [ $? -gt 0 ]
then
  aws cloudformation validate-template --template-body file://$template_body
  exit 1
else
  echo "Template is valid"
fi

#check if the stack exists
aws cloudformation describe-stacks --stack-name $stack_name > /dev/null 2>&1
res=$?
if [ $res -eq 254 ]
then
    echo 'Creating stack...'
    cmd='create-stack'
elif [ $res -eq 0 ]
then
    echo $res
    echo 'Updating stack...'
    cmd='update-stack'
else
    echo 'Unknown Error!'
    echo $res
    exit 1
fi

aws cloudformation $cmd \
--stack-name $stack_name \
--template-body file://$template_body \
--parameters file://$parameters \
--capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" \
--region=$region

if [ $? -eq 0 ]
then
  echo "Executed successfully..."
fi

