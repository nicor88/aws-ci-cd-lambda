import pandas
import requests


def lambda_handler(event, context):
    print('Hello World')
    print(requests.__version__)
    print(pandas.__version__)
    return {'output': 'hello world'}
