# 🏢 RetailFlow360 – Case Study

## 🎯 Problem Tanımı
Büyük bir perakende zinciri, farklı bölgelerdeki mağazalarından günlük olarak yüz binlerce işlem verisi üretiyor. Ancak bu veriler; satış sistemleri, kampanya platformları ve sensör cihazları gibi farklı kaynaklarda ve formatlarda saklanıyor.

**Şirketin yaşadığı başlıca sorunlar:**
- Verilerin merkezileştirilmemiş olması
- Gerçek zamanlı analiz yapılamaması
- Yöneticilerin veri destekli karar alamaması
- Modern GCP araçlarının eksikliği

---

## 🚩 Şirketin İhtiyaçları
1. Farklı kaynaklardan gelen verilerin tek yerde toplanması
2. Streaming ve batch verilerin entegre edilmesi
3. Otomatik ve hataya dayanıklı sistem kurulumu
4. Yöneticilere görsel ve etkileşimli dashboard’lar sunulması

---

## ✅ RetailFlow360 Çözümü
Google Cloud mimarisine benzer modern ve uçtan uca bir veri platformu inşa edildi.

### 1️⃣ Streaming Aşaması – IoT Simülasyonu
- **Kaynak:** `iot_stream.csv`
- `stream_iot_pub.py`: Verileri 1 saniyede bir Pub/Sub’a gönderir
- `subscriber_iot.py`: Veriyi Pub/Sub’tan dinleyip BigQuery’ye aktarır

**Teknolojiler:** Python, Pub/Sub, BigQuery

---

### 2️⃣ Batch Aşaması – PostgreSQL & MinIO
- `sales_data.csv`, `marketplace_data.csv`: PostgreSQL’e yüklendi
- `inventory_data.csv`: MinIO’ya yüklendi (S3 simülasyonu)

**Teknolojiler:** PostgreSQL, MinIO, Docker Compose

---

### 3️⃣ Airbyte – Veri Entegrasyonu
- Kaynaklar: PostgreSQL ve MinIO
- Hedef: BigQuery
- `abctl` CLI ile kurulum yapıldı

**Tüm veri kaynakları BigQuery’de birleşti**

---

### 4️⃣ DBT – Veri Dönüşümü
- **Staging:** Normalize işlemler (lower, trim, cast…)
- **Intermediate:** Tablo birleşimleri (join), hesaplamalar
- **Mart:** Yöneticilere yönelik özet metrikler

BigQuery'de oluşturulan veri setleri:
- `retail_stg`
- `retail_init`
- `retail_mart`

---

### 5️⃣ Looker Studio – Dashboard
Hazırlanan görseller:
- Product Category Performance Overview
- Sales vs Marketplace Quantity
- IoT Average Temperature & Humidity
- Active Sensor Count
- IoT Sensor Snapshot

---

### 6️⃣ Airflow – Otomasyon (Simülasyon)
Airbyte → DBT adımlarını yöneten DAG yazıldı:
- `airflow/dags/retailflow360_pipeline.py`
- Log dosyası örnek içerikle oluşturuldu

---

## 🔁 Genel Sistem Akışı
