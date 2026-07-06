from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    PROJECT_NAME: str = "CivicPulse API Gateway"
    API_V1_STR: str = "/api/v1"
    
    # Database Settings
    DATABASE_URL: str = "postgresql+psycopg2://postgres:postgres@localhost:5432/civicpulse"
    
    # Secret Key
    SECRET_KEY: str = "supersecretkeydevelopmentonlychangethisinprod"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 1440 # 24 hours
    
    # Third Party APIs
    BHASHINI_API_KEY: str = "mock_key"
    SENTINEL_API_KEY: str = "mock_key"
    WHATSAPP_API_TOKEN: str = "mock_key"

    class Config:
        case_sensitive = True
        env_file = ".env"

settings = Settings()
