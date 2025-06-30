import requests
import json
import time
import hashlib
import hmac
import base64

class KnoxBrityMeetingAPI:
    def __init__(self, client_code, secret_key, base_url):
        self.client_code = client_code
        self.secret_key = secret_key
        self.base_url = base_url
    
    def _generate_hmac(self, timestamp):
        message = f"{self.client_code}{timestamp}".encode('utf-8')
        secret = self.secret_key.encode('utf-8')
        signature = hmac.new(secret, message, hashlib.sha256).digest()
        return base64.b64encode(signature).decode('utf-8')
    
    def _get_headers(self, requester_id):
        timestamp = str(int(time.time() * 1000))
        hmac_token = self._generate_hmac(timestamp)
        
        headers = {
            "Client-Code": self.client_code,
            "Hmac": hmac_token,
            "Timestamp": timestamp,
            "Requester-Id": requester_id,
            "Content-Type": "application/json;charset=UTF-8"
        }
        return headers
    
    def create_meeting(self, requester_id, start_now, start_date, progress_minutes, title, participant_emails):
        url = f"{self.base_url}/front/v1/conferences/create"
        headers = self._get_headers(requester_id)
        
        payload = {
            "startNow": start_now,
            "startDate": start_date,
            "progressMinutes": progress_minutes,
            "title": title,
            "participantEmails": participant_emails
        }
        
        response = requests.post(url, headers=headers, data=json.dumps(payload))
        return response.json()
    
    def update_meeting(self, requester_id, conference_id, start_now, start_date, progress_minutes, title, 
                      add_participant_emails=None, remove_participant_emails=None):
        url = f"{self.base_url}/front/v1/conferences/{conference_id}/update"
        headers = self._get_headers(requester_id)
        
        payload = {
            "startNow": start_now,
            "startDate": start_date,
            "progressMinutes": progress_minutes,
            "title": title,
            "addParticipantEmails": add_participant_emails or [],
            "removeParticipantEmails": remove_participant_emails or []
        }
        
        response = requests.post(url, headers=headers, data=json.dumps(payload))
        return response.json()

if __name__ == "__main__":
    api = KnoxBrityMeetingAPI(
        client_code="TEST",
        secret_key="oGV1B2UgSa/XF1HaM56uJTLj1qgaLBVQO79S6ms7cDg=",
        base_url="https://stg.meeting.samsung.net"
    )
    
    create_response = api.create_meeting(
        requester_id="sonu.km@partner.samsung.com",
        start_now=False,
        start_date="2025-01-01 01:00",
        progress_minutes=60,
        title="Test Meeting",
        participant_emails=["sonu.km@partner.samsung.com", "ra.pathak@samsung.com", "rajanikant.s@samsung.com"]
    )
    print("Create Meeting Response:", create_response)
    
    # update_response = api.update_meeting(
    #     requester_id="requester-id-here",
    #     conference_id="12345",
    #     start_now=False,
    #     start_date="2025-01-01 02:00",
    #     progress_minutes=60,
    #     title="Updated Test Meeting",
    #     add_participant_emails=["new@example.com"]
    # )
    # print("Update Meeting Response:", update_response)