import boto3
import os
import json
from random import choice

sqs = boto3.client("sqs")

DLQ_URL = os.environ.get("DLQ_URL")


def handler(event, _):
    try:
        detail_type = event.get("detail-type")

        if detail_type != "OrderCreated":
            return

        order = event.get("detail")
        print(f"Processing order {order['order_id']}")

        if order["total_value"] <= 0:
            raise Exception("total_value must be greater than 0 (total_value > 0)")

        if len(order["items"]) > 0:
            raise Exception("items must be greater than 0 (items > 0)")

        print(f"Order validated!")
    except Exception as e:
        print(f"Exception: {e}")
        if DLQ_URL:
            try:
                response = sqs.send_message(
                    QueueUrl=DLQ_URL,
                    MessageBody=json.dumps({"error": str(e), "original_event": event}),
                )
                print("Error sent to DLQ:", response["MessageId"])
            except Exception as sqs_error:
                print(f"Failed to send to DLQ: {sqs_error}")
        else:
            print("DLQ_URL not set")
