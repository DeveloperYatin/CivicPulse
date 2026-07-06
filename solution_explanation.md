# CivicPulse Solution Explanation 🏛️

**CivicPulse** is an AI-powered civic operating layer connecting Indian citizens directly with representatives (MLAs/MPs) to bridge the digital divide.

### Core Features
- **Ambient Voice (Bhashini/Whisper STT):** Dynamic UX modes allowing zero-literacy voice reporting in 22 languages.
- **5-Signal Trust Engine:** Combines PostGIS geofencing, spatial clustering, and satellite checks to flag spam.
- **Aadhaar Deduplication:** Cryptographic SHA-256 hashing to limit inputs to 3 complaints/month (DPDP Act 2023 compliant).
- **Decentralized Verification:** Automated 30-user neighborhood geofenced polls (Haan/Nahi) to verify local issues.
- **Zero-Adoption Barrier:** Representatives receive daily summarized briefs via WhatsApp.

### Technical Stack
Built as a monorepo: Flutter/Dart (Mobile/Web), Python FastAPI backend, PostgreSQL/PostGIS spatial database, and Bhashini translation API. Deployment scales from pilot constituencies to national scale.
