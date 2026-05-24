ARG AIRFLOW_VERSION=2.8.4
ARG PYTHON_VERSION=3.11
 
FROM apache/airflow:${AIRFLOW_VERSION}-python${PYTHON_VERSION}

# Switch to root for level installment

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    libpq-dev \
    gcc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


USER airflow
COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt


# --------- Projects Directories -----------------

RUN mkdir -p \
    /opt/airflow/data/raw \
    /opt/airflow/data/intermediate \
    /opt/airflow/data/curated \
    /opt/airflow/data/reference \
    /opt/airflow/data/logs