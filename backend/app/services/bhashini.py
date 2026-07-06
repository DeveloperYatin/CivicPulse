import httpx
from app.core.config import settings

class BhashiniService:
    def __init__(self):
        self.api_key = settings.BHASHINI_API_KEY
        self.base_url = "https://meity.bhashini.gov.in/v1" # Target Bhashini API gateway URL

    async def translate_text(self, text: str, source_lang: str, target_lang: str = "en") -> str:
        """
        Translates raw issue texts from 22 official regional Indian languages to English
        using government-backed Bhashini translation pipelines.
        """
        if self.api_key == "mock_key":
            # Mock translation response for local development / pipeline verification
            mock_translations = {
                "यहाँ वार्ड 12 में मुख्य पानी की पाइपलाइन फट गई है और सड़क पर बहुत पानी बह रहा है।": 
                "A main water pipeline has burst here in Ward 12, causing water logging on the streets."
            }
            return mock_translations.get(text, f"[Translated from {source_lang}]: {text}")
        
        # Real integration HTTP call
        async with httpx.AsyncClient() as client:
            headers = {"Authorization": f"Bearer {self.api_key}", "Content-Type": "application/json"}
            payload = {
                "text": text,
                "source": source_lang,
                "target": target_lang
            }
            try:
                response = await client.post(f"{self.base_url}/translate", json=payload, headers=headers, timeout=10.0)
                response.raise_for_status()
                data = response.json()
                return data.get("translatedText", text)
            except Exception as e:
                # Fallback to source on exception
                return f"[Fallback]: {text}"

bhashini_service = BhashiniService()
