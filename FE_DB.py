
# -*- coding: utf-8 -*-
# 3.14~ 

# cd ITDA\itda_2
# install : (base) C:\Users\nahyun\ITDA\itda_2>pip install streamlit
# Run : (base) C:\Users\nahyun\ITDA\itda_2>streamlit run itda_2.py



# 2) simple sign-up process (Streamlit)
#import streamlit as st

#st.title("Sign Up")

#id = st.text_input("Enter your ID")
#password = st.text_input("Enter your password", type="password")

#if st.button("Sign Up"):
#   st.success(f"Sign up request: {id}")


#4) FE <-> DB Connect 

import streamlit as st
from DB_BE import register_user 

# Streamlit UI
st.title("Sign Up")

id = st.text_input("Enter your ID")
password = st.text_input("Enter your password", type="password")

if st.button("Sign Up"):
    if register_user(id, password):
        st.success(f"Sign up request: {id}")
    else:
        st.error("fail, try again")

