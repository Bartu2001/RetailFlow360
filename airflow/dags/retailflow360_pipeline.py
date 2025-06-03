from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

default_args = {
    'owner': 'bartu',
    'start_date': datetime(2025, 6, 3),
}

with DAG(
    dag_id='retailflow360_pipeline',
    default_args=default_args,
    schedule_interval=None,
    catchup=False,
    description='Simulated ELT pipeline for RetailFlow360 case study',
) as dag:

    run_dbt_models = BashOperator(
        task_id='run_dbt_models',
        bash_command='echo "Simulated DBT run for GitHub presentation"',
    )
