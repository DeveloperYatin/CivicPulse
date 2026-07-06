# CivicPulse - Technology Stack Blueprint

This document outlines the complete technical architecture and software stack proposed for building the **CivicPulse** constituency planning platform.

---

## 1. Frontend & Mobile Client (Interaction Layer)
*   **Flutter & Dart:** Single codebase for deploying cross-platform mobile apps (Citizen Client, MLA Ward Tracker, and Gram Panchayat Offline Dashboard) optimized for low-end Android smartphones.
*   **Flutter & Dart (Web):** Responsive, high-fidelity web dashboard for MP offices and their Personal Assistants to visualize regional heatmaps and manage ticket queues, sharing the core Flutter codebase.
*   **IVR & Audio Streaming Protocols (SIP/VoIP):** Connects analogue telephone lines directly to our speech models, allowing zero-literacy users to report issues via voice-only phone calls.

## 2. Artificial Intelligence & NLP (Processing Layer)
*   **Bhashini API (Govt. of India):** Core engine for real-time translation, transliteration, and validation across 22 official Indian languages and local dialects.
*   **Whisper STT (Speech-to-Text):** Open-source speech transcription engine fine-tuned for high-accuracy processing of audio recordings containing ambient noise and regional accents.
*   **LLM Orchestration (Gemini / Claude API):** Extracts structured data (category, urgency, location keywords) from raw transcription texts and drafts daily WhatsApp digests for representatives.
*   **Vision Transformers / YOLO:** Mobile-friendly vision models to run automated verification checks (e.g., detecting pavement cracks, potholes, or broken taps) on user photo uploads.

## 3. Data & Geographic Information Systems (GIS) (Verification Layer)
*   **PostGIS & PostgreSQL:** Extends a relational database with spatial indexes to calculate coordinates, geofences, and run clustering algorithms (detecting duplicate complaints in a radius).
*   **ISRO Sentinel-2 Satellite API:** Programmatic GIS checks to fetch recent visual bands to cross-verify major physical infrastructure claims (e.g., verifying road development or bridges).
*   **OpenStreetMap API:** Lightweight road and structure routing verification to map complaints to correct municipal wards.
*   **SHA-256 Hashing System:** Generates a secure, one-way hash of Aadhaar credentials for monthly complaint rate-limiting (3 submissions max per user) in strict compliance with the **DPDP Act 2023**.

## 4. Backend & Communication (Infrastructure Layer)
*   **Python (FastAPI) / Node.js:** Async backend servers handling core business logic, database queries, and routing pipelines.
*   **WhatsApp Business API:** Automates the daily morning digest and simple action forwarders directly to representatives' personal phones.
*   **Twilio / Exotel APIs:** Manages outgoing automated IVR verification calls ("Haan ya Nahi" responses) and SMS notifications for ticket lifecycle updates.

---

## Organizer Submission Summary (One-Liner)

> **CivicPulse is an AI-powered civic operating layer built with Flutter, Python, and PostgreSQL that leverages India’s Bhashini translation API, Whisper STT, and ISRO Sentinel-2 satellite data to connect rural citizens directly with elected representatives via ambient voice inputs, automated WhatsApp briefs, and decentralized community verification.**
