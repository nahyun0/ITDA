# 3) Connect DB <-> python (BE)
# pip install mysql-connector-python 

import streamlit as st
import mysql.connector
import hashlib

# MySQL Connect 
def create_connection():
    try:
        conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="개인비밀번호",
            database="itda_db",
            port="개인포트번호"
        )
        print("Database connection successful")  # 연결 성공 메시지
        return conn

    except mysql.connector.Error as err:
        print(f"Error: {err}")  # 연결 실패 메시지
        return None


# PassWord Hashing (encryption) 비밀번호 암호화 
def hash_password(password):
    return hashlib.sha256(password.encode()).hexdigest()

# Register 등록시 데베와 연결 
def register_user(id, password):
    conn = create_connection()
    cursor = conn.cursor()

    hashed_pw = hash_password(password)

    try:
        cursor.execute("INSERT INTO users (id, password) VALUES (%s, %s)", (id, hashed_pw)) #sql 입력 쿼리문 
        conn.commit()
        return True

    except Exception as e:
        print("error:", e)
        return False

    finally:
        cursor.close()
        conn.close()


