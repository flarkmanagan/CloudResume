import json
import boto3
from botocore.exceptions import ClientError

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('SiteVisits')

def lambda_handler(event, context):
    try:
        response = table.get_item(Key={'id': 'visits'})
        # .get() is a native python dictionary method to retrieve the value associated with the key 'count'
        # the second param in .get() is the value to be returned if it can't find a value for 'count'
        visCount = int(response['Item'].get('visitorCount', 0)) #convert to int as ddb uses decimal type for numbers
        visCount += 1

        table.update_item(
            Key={
                'id': 'visits'
            },
            UpdateExpression='SET visitorCount = :val',
            ExpressionAttributeValues={
                ':val': visCount
            }
        )

        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': 'https://markflanagan.org'
            },
            'body': json.dumps({'visitorCount': visCount})

        }
    
    except ClientError as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f"Error updating visitor count: {e.response['Error']['Message']}")
        }