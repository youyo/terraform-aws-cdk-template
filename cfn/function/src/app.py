import boto3
import os


def handler(event, context):
    foo = os.getenv('FOO')
    print(foo)

    s = boto3.Session()
    r = s.get_available_regions('s3')
    print(r)

    return True
