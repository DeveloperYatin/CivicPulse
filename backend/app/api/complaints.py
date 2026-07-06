from fastapi import APIRouter, Depends, HTTPException, BackgroundTasks
from pydantic import BaseModel
from typing import List, Optional
from app.services.bhashini import bhashini_service
from app.services.sentinel import sentinel_service

router = APIRouter()

class ComplaintCreate(BaseModel):
    citizen_voice_text: str
    language_code: str
    latitude: float
    longitude: float
    user_aadhaar_hash: str # Anonymized secure SHA-256 string for monthly limit checks

class ComplaintResponse(BaseModel):
    id: int
    original_text: str
    translated_text: str
    category: str
    urgency: str
    latitude: float
    longitude: float
    isro_verified: bool
    status: str

# In-memory mock storage
mock_complaints_db = []

@router.post("/", response_model=ComplaintResponse)
async def lodge_complaint(complaint: ComplaintCreate, background_tasks: BackgroundTasks):
    # 1. Check rate-limit (DPDP Act compliance - 3 complaints maximum monthly)
    aadhaar_count = sum(1 for c in mock_complaints_db if c["user_aadhaar_hash"] == complaint.user_aadhaar_hash)
    if aadhaar_count >= 3:
        raise HTTPException(
            status_code=429, 
            detail="Rate limit exceeded. Maximum 3 complaints allowed per citizen monthly in compliance with DPDP Act 2023."
        )

    # 2. Multilingual translation with Bhashini API
    english_translation = await bhashini_service.translate_text(
        text=complaint.citizen_voice_text,
        source_lang=complaint.language_code
    )

    # 3. GIS cross-verification with ISRO Sentinel APIs
    gis_check = await sentinel_service.verify_infrastructure_change(
        latitude=complaint.latitude,
        longitude=complaint.longitude,
        description=english_translation
    )
    
    isro_verified = gis_check.get("status") == "verified"

    # 4. Save ticket record
    ticket_id = len(mock_complaints_db) + 1
    new_ticket = {
        "id": ticket_id,
        "original_text": complaint.citizen_voice_text,
        "translated_text": english_translation,
        "category": "Infrastructure & Public Works",
        "urgency": "High" if "water" in english_translation.lower() or "burst" in english_translation.lower() else "Medium",
        "latitude": complaint.latitude,
        "longitude": complaint.longitude,
        "isro_verified": isro_verified,
        "status": "Open",
        "user_aadhaar_hash": complaint.user_aadhaar_hash
    }
    
    mock_complaints_db.append(new_ticket)
    
    # 5. Dispatch representative notification in background
    # background_tasks.add_task(whatsapp_service.notify_mla, new_ticket)
    
    return new_ticket

@router.get("/", response_model=List[ComplaintResponse])
async def list_complaints(latitude: Optional[float] = None, longitude: Optional[float] = None):
    """
    Returns all logged tickets. If coordinates are provided, PostGIS spatial calculations
    would run geofenced radius clustering queries here.
    """
    return mock_complaints_db
