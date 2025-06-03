import json
from google.cloud import pubsub_v1
from google.cloud import bigquery

# GCP information
project_id = "data-analytics-36871212"
subscription_id = "iot-stream-sub"
path_to_credentials = "creds/data-analytics-36871212-373726a69923.json"

# BigQuery settings
bq_client = bigquery.Client.from_service_account_json(path_to_credentials)
table_id = "retail_dataset.iot_stream"

def callback(message):
    print(f"Received: {message.data.decode('utf-8')}")
    row = eval(message.data.decode("utf-8"))  # Convert to dict
    errors = bq_client.insert_rows_json(table_id, [row])
    if not errors:
        print("Written to BigQuery.")
        message.ack()
    else:
        print("Error:", errors)

subscriber = pubsub_v1.SubscriberClient.from_service_account_file(path_to_credentials)
subscription_path = subscriber.subscription_path(project_id, subscription_id)
subscriber.subscribe(subscription_path, callback=callback)

print(f"Listening: {subscription_path} ... Stop with Ctrl+C.")
import time
while True:
    time.sleep(10)
