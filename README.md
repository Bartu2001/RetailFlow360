# RetailFlow360 – GCP Data Engineering Case Study 🚀

This project simulates a modern retail data platform using Google Cloud tools.  
The objective is to create an end-to-end batch + streaming pipeline with proper transformations and a final dashboard layer.

## 💼 Business Case

A large retail chain wants to unify sales data from various sources and make real-time data-driven decisions. However, current data is scattered in different systems, making analytics slow and ineffective.

## 🔧 Tools Used

- **PostgreSQL** → Simulates relational sales data source
- **MinIO** → S3-compatible data lake for CSV files
- **Airbyte** → Ingests data from PostgreSQL/MinIO to BigQuery
- **BigQuery** → Cloud Data Warehouse for analytics
- **DBT** → Data transformation (staging, intermediate, marts)
- **Python** → Simulated real-time Pub/Sub data
- **Looker Studio** → Dashboard layer
- **Airflow (Mocked)** → Orchestrator, shows automation design

## 📁 Folder Structure

- `dbt/` → Contains staging, intermediate, and marts models
- `data/` → All raw CSV data files
- `minio_data/` → Mounted by MinIO
- `creds/` → GCP service account key (gitignored)
- `stream/` → Python scripts for publishing and subscribing to Pub/Sub
- `airflow/` → DAG file and simulated log
- `.env`, `docker-compose.yml` → Environment and orchestration setup

## 📊 Dashboards

Created using **Looker Studio**, showcasing:
- Sales performance
- Low stock alerts
- IoT sensor activity
- Marketplace vs. in-store comparison

## ⚙️ How to Run (Optional for GitHub Viewers)

This project is designed to simulate a real pipeline, so no actual GCP billing or secrets are required.

