import boto3
import os

# Change this to the endpoint from your bucket details, prefixed with "https://"
ENDPOINT_URL = 'https://s3.us-east-005.backblazeb2.com'

# Create a Boto3 Session with the tutorial profile
b2session = boto3.session.Session(profile_name='nerv-server')


# Create a Boto3 Resource from the session, specifying Amazon S3 as the service, and our B2 endpoint
b2 = b2session.resource(service_name='s3',
                        endpoint_url=ENDPOINT_URL)

# Get the list of buckets
buckets = b2.buckets.all()

# Iterate through the list, printing each bucket's name
print('Buckets in account:')
for bucket in buckets:
    print(bucket.name)
