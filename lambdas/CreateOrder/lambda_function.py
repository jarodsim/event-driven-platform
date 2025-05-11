import boto3
import json
import os

eventbridge = boto3.client("events")


def handler(event, _):
    try:
        order: dict = event.get("body")
        customer_id = order.get("customer_id")
        order_id = order.get("order_id")
        total_value = order.get("total_value")
        items = order.get("items")
        email = order.get("email")

        if not all([customer_id, order_id, total_value, items, email]):
            return {
                "statusCode": 400,
                "body": json.dumps({"error": "Missing required fields"}),
            }

        response = eventbridge.put_events(
            Entries=[
                {
                    "Source": "edp.orders",
                    "DetailType": "OrderCreated",
                    "Detail": json.dumps(order),
                    "EventBusName": os.environ["EVENT_BUS_NAME"],
                }
            ]
        )

        return {
            "statusCode": 200,
            "body": json.dumps(
                {
                    "message": "Pedido publicado com sucesso",
                    "event_id": response["Entries"][0].get("EventId"),
                }
            ),
        }
    except Exception as e:
        print(f"Error: {e}")
        return {"statusCode": 500, "body": "Internal Server Error"}
