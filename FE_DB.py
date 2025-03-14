
# -*- coding: utf-8 -*-

#4) FE <-> DB 연결 확인 해본 것 ( id, password 입력시 mySQL 쪽에서 저장이 되는 지) 
#  Streamlit을 사용하여 사용자 인터페이스(UI)를 담당하는 부분 관련 

# pip install streamlit (설치)
# streamlit run FE_DB.py (실행) 

import streamlit as st
from DB_BE import register_user # DB_BE.py의 

# Streamlit UI
st.title("Sign Up")

id = st.text_input("Enter your ID")
password = st.text_input("Enter your password", type="password")

if st.button("Sign Up"):
    if register_user(id, password):
        st.success(f"Sign up request: {id}")
    else:
        st.error("fail, try again")

