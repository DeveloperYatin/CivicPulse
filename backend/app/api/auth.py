from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
import jwt
from datetime import datetime, timedelta
from app.core.config import settings

router = APIRouter()

class UserLogin(BaseModel):
    username: str
    password: str

class TokenResponse(BaseModel):
    access_token: str
    token_type: str
    role: str
    name: str

@router.post("/token", response_model=TokenResponse)
async def login(user: UserLogin):
    # Simulated accounts mapping roles to testing portals
    credentials = {
        "citizen": {"role": "Citizen", "name": "Yatin Batra", "pass": "citizen123"},
        "mla_ward5": {"role": "MLA_Representative", "name": "MLA Ward 5 Office", "pass": "mla123"},
        "panchayat_admin": {"role": "Gram_Panchayat", "name": "Govindpuri Panchayat Admin", "pass": "panchayat123"},
        "mp_admin": {"role": "MP_Office", "name": "District MP Office PA", "pass": "mp123"}
    }
    
    account = credentials.get(user.username.lower())
    if not account or account["pass"] != user.password:
        raise HTTPException(status_code=401, detail="Incorrect credentials. Try citizen/citizen123, mla_ward5/mla123, panchayat_admin/panchayat123, or mp_admin/mp123.")

    payload = {
        "sub": user.username,
        "role": account["role"],
        "name": account["name"],
        "exp": datetime.utcnow() + timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    }
    
    token = jwt.encode(payload, settings.SECRET_KEY, algorithm=settings.ALGORITHM)
    
    return {
        "access_token": token,
        "token_type": "bearer",
        "role": account["role"],
        "name": account["name"]
    }
