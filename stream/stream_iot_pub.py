import csv
import time
from google.cloud import pubsub_v1

# GCP bilgileri
project_id = "data-analytics-36871212"
topic_id = "iot-stream"
path_to_credentials = "creds/data-analytics-36871212-373726a69923.json"

# Publisher ayarı
publisher = pubsub_v1.PublisherClient.from_service_account_file(path_to_credentials)
topic_path = publisher.topic_path(project_id, topic_id)

# CSV dosyası
csv_file_path = "data/iot_stream.csv"

with open(csv_file_path, "r") as file:
    reader = csv.DictReader(file)
    for row in reader:
        message = str(row).encode("utf-8")
        future = publisher.publish(topic_path, data=message)
        print(f"Published: {message}")
        time.sleep(0.01)  # 100 satır/sn

print("Tüm mesajlar gönderildi.")
