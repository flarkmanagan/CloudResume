import json
import boto3
from botocore.exceptions import ClientError

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('SiteVisits')

def lambda_handler(event, context):
    message = ""
    try:
        response = table.get_item(Key={'id': 'visits'})

        if 'Item' not in response:
            table.put_item(Item={'id': 'visits', 'visitorCount': 0})
            message = "Table initialized"
        else:
            message = "Table item already exists"

        
        return {
            'statusCode': 200,
            'body': json.dumps(message)
        }
    
    except ClientError as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f"Error initialising database: {e.response['Error']['Message']}")
        }

        
