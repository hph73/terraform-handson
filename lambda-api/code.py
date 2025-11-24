# import json
# def lambda_handler(event, context):
#     print(event)
#     return {
#         'statusCode': 200,
#         'body': json.dumps('Hello from aws cloud demos!!!')
#     }

import boto3
import time
import os
import json

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(os.environ["TABLE_NAME"])

def lambda_handler(event, context):
    print("event", event)
    print("context", context)
    body = json.loads(event["body"])
    item_id = str(int(time.time()))
    table.put_item(
        Item = {
            "UserId": item_id,
            "OrderId": body["OrderId"],
            "Email": body["Email"],
        }
    )
    return {
        'statusCode': 200,
        'body': json.dumps({"message": f'Item created with id {item_id}'})
    }