#!/usr/bin/python3
# A simple program to test boto and print s3 bucket names
import boto3
t = boto3.resource('s3')
for b in t.buckets.all():
    print(b.name)
