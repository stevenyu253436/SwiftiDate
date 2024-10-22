import firebase_admin
from firebase_admin import credentials, db

# 初始化 Firebase Admin SDK
cred = credentials.Certificate('./swiftidate-cdff0-firebase-adminsdk-e2p44-7c5e06ebfc.json')  # 替換為你的 service account 憑證檔案路徑
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://swiftidate-cdff0-default-rtdb.asia-southeast1.firebasedatabase.app/'  # 替換為你的 Firebase Realtime Database URL
})

# 讀取原始的聊天資料
ref = db.reference('users/userID_1/userMatches')  # 替換為你實際的路徑
user_matches = ref.get()

if user_matches and isinstance(user_matches, list):
    # 對 userMatches 進行倒序排序
    sorted_user_matches = list(reversed(user_matches))
    
    # 更新 Firebase 資料庫
    ref.set(sorted_user_matches)
    print("UserMatches sorted in reverse order and updated successfully.")
else:
    print("No userMatches data found or data format is not a list.")
