DROP DATABASE itda_db;
CREATE DATABASE itda_db;
USE itda_db;

# 초안 - https://chatgpt.com/share/67d5ab12-0dd0-8010-b2b3-b3e3a4cb521e 
# 로그인/회원가입 
CREATE TABLE users (
    userid VARCHAR(50) NOT NULL PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(50),
    age INT
);
DROP TABLE users;
DESC users;
SELECT User, Host FROM mysql.user;
SELECT * FROM users;

#책 선택 
CREATE TABLE books (
    bookid INT PRIMARY KEY AUTO_INCREMENT, #AUTO_INCREMEN은 자동으로 숫자를 1부터 증가 중복x
    title VARCHAR(255),
    author VARCHAR(255),
    category VARCHAR(50)
);

# ! - varchar()와 text 차이점 : 공간적 제약, 최대 저장 길이 미리할당, 최대 길이가(상대적으로) 크지 않은 경우  / text는 길이가 길어서 저장공간이 많이 필요한 경우 

# 책 퀴즈 질문 
# 퀴즈가 a,b,c,d 중 고르는 경우 
# 책 하나에 퀴즈 질문이 3-5개라 가정 하면 bookid는 동일하되 quesrionid는 다르다. 1:N 
# 복합 키 사용 ( bookid, questionid) 
CREATE TABLE books_questions (
	bookid INT,  -- 책과 연결 (FK)
    questionid INT, 
    question TEXT,  -- 퀴즈 질문
    option_a TEXT,  -- 선택지 A 내용 
    option_b TEXT,  -- 선택지 B
    option_c TEXT,  -- 선택지 C
    option_d TEXT,  -- 선택지 D
    correct_answer CHAR(1),  -- 정답 (a, b, c, d) 중에서 하나 
    PRIMARY KEY (bookid, questionid),  -- 복합 키
    FOREIGN KEY (bookid) REFERENCES books(bookid)
);

# 독서 기록 (읽기 시작) 
CREATE TABLE reading_sessions (
    sessionid INT PRIMARY KEY AUTO_INCREMENT,
    userid VARCHAR(50), -- FK
    bookid INT, -- FK
    starttime DATETIME,
    endtime DATETIME,
    totaltime INT,  -- 읽은 총 시간 (초)
    FOREIGN KEY (userid) REFERENCES users(userid),
    FOREIGN KEY (bookid) REFERENCES books(bookid)
);

# 읽는 중 ( eyetrackingData는 mongoDB 쪽에서) 

#퀴즈 제공 , 결과 저장 
CREATE TABLE quiz_results (
    resultid INT PRIMARY KEY AUTO_INCREMENT,
    sessionid INT,  -- 해당 세션 ID (FK) 
    bookid INT,
    questionid INT,  -- 어떤 질문인지 (FK) 
    user_answer CHAR(1),  -- 사용자가 선택한 답 (a, b, c, d)
    is_correct BOOLEAN,  -- 정답여부 (true/false)
    # score = (맞춘 개수/ 전체 문제 개수) * 100 비율로 계산 
    FOREIGN KEY (sessionid) REFERENCES reading_sessions(sessionid),
	FOREIGN KEY (bookid, questionid) REFERENCES books_questions(bookid, questionid)
);

#! score 계산 방법 sql문 예시
# SELECT sessionid, (SUM(is_correct) * 100 / COUNT(*)) AS score 
# FROM quiz_results
# WHERE sessionid = ? ; 


#피드백 
#!- 수정 필요
# 일단은 score >= 90일 경우 피드백 ~문장 이라고 생각시 
CREATE TABLE feedbacks (
    feedbackid INT AUTO_INCREMENT PRIMARY KEY,      -- 피드백 고유 ID
    sessionid INT,                         -- (FK)
    feedback_text TEXT,                    -- 피드백 내용 
    FOREIGN KEY (sessionid) REFERENCES reading_sessions(sessionid)
);



