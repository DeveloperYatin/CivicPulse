# CivicPulse Backend - Python FastAPI

This is the asynchronous Python backend server for the **CivicPulse** constituency planning platform. It manages the core business logic, geofencing queries using PostgreSQL/PostGIS, AI workflow orchestration (multilingual speech via Bhashini and Whisper), satellite verification (ISRO Sentinel-2 APIs), and representative WhatsApp/SMS notifications.

---

## Technical Stack

*   **FastAPI:** Asynchronous, high-performance web framework.
*   **PostgreSQL & PostGIS:** Spatial database engine to track coordinate clustering and ward boundary overlaps.
*   **Bhashini API:** Real-time Indian language translation and audio transcription engine.
*   **ISRO Sentinel-2 API:** GIS verification of infrastructure claims.
*   **Twilio / Exotel & WhatsApp Business APIs:** Dispatching alerts and ticket lifecycle notifications.

---

## Directory Layout

```
backend/
├── requirements.txt      # Python package dependencies
├── Dockerfile            # Container deployment configurations
├── README.md             # This setup guide
└── app/
    ├── main.py           # FastAPI application initialization
    ├── core/             # Configuration, Database connections, and Security utilities
    ├── api/              # Route endpoints (Complaints, Translate, Verifications, Auth)
    ├── models/           # SQLAlchemy / GeoAlchemy2 spatial models
    ├── schemas/          # Pydantic serialization models
    └── services/         # Integrations (Bhashini translate, ISRO Sentinel spatial verify, Whisper STT)
```

---

## Local Setup

### 1. Configure Python Virtual Environment
We recommend using Python 3.11+. In this directory:
```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### 2. Configure Environment Variables
Create a `.env` file in the root backend directory:
```env
DATABASE_URL=postgresql+psycopg2://user:password@localhost:5432/civicpulse
BHASHINI_API_KEY=your_bhashini_key
SENTINEL_API_KEY=your_isro_sentinel_key
JWT_SECRET=your_jwt_secret_signature
```

### 3. Run Development Server
```bash
uvicorn app.main:app --reload --port 8000
```
Visit `http://localhost:8000/docs` to test endpoint schemas and APIs via Swagger documentation.
