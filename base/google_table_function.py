from oauth2client.service_account import ServiceAccountCredentials
import gspread


class GSpread:
    """
    Class for interacting with an google spreadsheet
    """
    GOOGLE_ACCOUNT_CREDS = './config/creds.json'
    def __init__(self, spreadsheet_id):
        self.spreadsheet_id = spreadsheet_id

    def worksheet(self, ws_name):
        scope = ['https://spreadsheets.google.com/feeds',
                 'https://www.googleapis.com/auth/drive']
        credentials = ServiceAccountCredentials.from_json_keyfile_name(self.GOOGLE_ACCOUNT_CREDS, scope)
        gc = gspread.authorize(credentials)
        sh = gc.open_by_key(self.spreadsheet_id)
        ws = sh.worksheet(ws_name)
        return ws




