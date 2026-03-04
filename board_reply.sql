USE univdb;

-- =========================
-- 1) 테이블 생성
-- =========================
CREATE TABLE IF NOT EXISTS board (
  bno INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(100) NOT NULL,
  content VARCHAR(1000) NOT NULL,
  writer VARCHAR(50) NOT NULL,
  regdate DATETIME DEFAULT now(),
  updatedate DATETIME DEFAULT now(),
  PRIMARY KEY (bno)
);

CREATE TABLE IF NOT EXISTS reply (
  rno INT NOT NULL AUTO_INCREMENT,
  bno INT NOT NULL,
  reply VARCHAR(1000) NOT NULL,
  replyer VARCHAR(50) NOT NULL,
  replydate DATETIME DEFAULT now(),
  updatedate DATETIME DEFAULT now(),
  PRIMARY KEY (rno),
  CONSTRAINT fk_reply_board FOREIGN KEY (bno) REFERENCES board(bno) ON DELETE CASCADE
);

-- =========================
-- 2) 데이터 초기화/재입력
-- =========================
SET SQL_SAFE_UPDATES = 0;
DELETE FROM reply;
DELETE FROM board;
ALTER TABLE board AUTO_INCREMENT = 1;
ALTER TABLE reply AUTO_INCREMENT = 1;

INSERT INTO board (title, content, writer) VALUES
('첫 글', '게시판 테스트입니다.', 'kim'),
('SQL 질문', '저장 프로시저는 언제 쓰나요?', 'lee'),
('공지', '프로젝트 일정 공유합니다.', 'admin');

INSERT INTO reply (bno, reply, replyer) VALUES
(1, '환영합니다!', 'park'),
(1, '첫 글 축하해요.', 'choi'),
(2, '저장 프로시저 재사용할 때 좋아요.', 'hong');

-- =========================
-- 3) 조회하기
-- =========================
SELECT * FROM board ORDER BY bno;
SELECT * FROM reply ORDER BY rno;

SELECT
  b.bno, b.title, b.writer,
  r.rno, r.reply, r.replyer
FROM board b
LEFT JOIN reply r ON b.bno = r.bno
ORDER BY b.bno, r.rno;
