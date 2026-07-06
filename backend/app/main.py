from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.core.config import settings
from app.api import complaints, auth

app = FastAPI(
    title=settings.PROJECT_NAME,
    description="Backend API Gateway handling AI language processing, Sentinel-2 spatial verifications, and constituency ticketing workflows.",
    version="1.0.0",
)

# CORS Policy configuration for Flutter client communication (Mobile and Web Dashboards)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], # In development, adjust for security constraints in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Mount Endpoint Routers
app.include_router(auth.router, prefix=f"{settings.API_V1_STR}/auth", tags=["Authentication"])
app.include_router(complaints.router, prefix=f"{settings.API_V1_STR}/complaints", tags=["Complaints & Tickets"])

@app.get("/")
def read_root():
    return {
        "status": "online",
        "service": settings.PROJECT_NAME,
        "docs_url": "/docs"
    }
