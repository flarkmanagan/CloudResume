import json
import boto3
from botocore.exceptions import ClientError
from boto3.dynamodb.conditions import Attr

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('SiteVisits')

def lambda_handler(event, context):
    try:
        response = table.get_item(Key={'id': 'visits'})

        if 'Item' not in response:
            table.put_item(Item={'id': 'visits', 'visitorCount': 0})
        
        response = table.update_item(
            Key={
                'id': 'visits'
            },
            UpdateExpression='SET visitorCount = if_not_exists(visitorCount, :start) + :increment',
            ExpressionAttributeValues={
                ':start': 0,
                ':increment': 1,
            },
            ReturnValues='UPDATED_NEW'
        )

        visitor_count = int(response['Attributes']['visitorCount'])

        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*' # change back to https://markflanagan.org after testing
            },
            'body': json.dumps({'visitorCount': visitor_count})
        }
    
    except ClientError as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f"Error updating visitor count: {e.response['Error']['Message']}")
        }