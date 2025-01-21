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
        
        # .get() is a native python dictionary method to retrieve the value associated with the key 'count'
        # the second param in .get() is the value to be returned if it can't find a value for 'count'
        #visCount = int(response['Item'].get('visitorCount', 0)) #convert to int as ddb uses decimal type for numbers
        #visCount += 1

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