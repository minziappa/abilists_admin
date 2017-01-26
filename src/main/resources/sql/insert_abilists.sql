INSERT INTO abilists.abilists_sequence (seq_name, id, seq_explain) VALUES('userTemp', 0, 'for registering user in temp');
INSERT INTO abilists.abilists_sequence (seq_name, id, seq_explain) VALUES('notification', 0, 'for notification');

INSERT INTO abilists.m_industry (mi_large_category, mi_middle_category, mi_code, mi_explain, ml_code, mi_status, mi_delete, insert_time, update_time) VALUES('finance', 'bank', '001', 'handling money', 'en', '0', '0', now(), now());
INSERT INTO abilists.m_industry (mi_large_category, mi_middle_category, mi_code, mi_explain, ml_code, mi_status, mi_delete, insert_time, update_time) VALUES('금융', '은행', '001', '돈 관리', 'ko', '0', '0', now(), now());
INSERT INTO abilists.m_industry (mi_large_category, mi_middle_category, mi_code, mi_explain, ml_code, mi_status, mi_delete, insert_time, update_time) VALUES('', '은행', '001', '돈 관리', 'jp', '0', '0', now(), now());

INSERT INTO abilists.m_language (ml_code, ml_name, ml_english_name, ml_status, ml_delete, insert_time, update_time) VALUES('en', 'English', 'English', '0', '0', now(), now());
INSERT INTO abilists.m_language (ml_code, ml_name, ml_english_name, ml_status, ml_delete, insert_time, update_time) VALUES('ko', '한국', 'Korea', '0', '0', now(), now());
INSERT INTO abilists.m_language (ml_code, ml_name, ml_english_name, ml_status, ml_delete, insert_time, update_time) VALUES('ja', '日本', 'Japan', '0', '0', now(), now());

INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','language','Java','1.7','java1.7 explain','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','language','C++','11','C++ 11','r1','old','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','language','C','2.0','TurboC','r1','old','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','language','C#','4.0','Microsoft C#','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','language','Objective-c','1.0','Apple','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','language','Ruby','2.3.1','Apple','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','language','Bash Shell','2.1','Linux','r1','new','0','0',now(),now());

INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','Web','HTML','2.0','Web HTML','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','Web','XML','1.0','Web XML','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','Web','JSP','1.0','Web JSP','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','Web','Jquery','1.0','Web Jquery','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','Web','JavaScript','1.0','Web JavaScript','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','Web','JSON','2.0','Web JSON','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','Web','Ajax','2.0','Web Ajax','r1','new','0','0',now(),now());

INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','OS','Unix','7.5','OS unix','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','OS','Linux','6.5','OS linux','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','OS','Windows','7','OS Windows','r1','new','0','0',now(),now());

INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','Middleware','ActiveMq','7','ActiveMq5.0','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','Middleware','APACHE','2.0','APACHE2.0','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','Middleware','TOMCAT','7.0','TOMCAT7.0','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','Middleware','Memcached','2.0','TOMCAT7.0','r1','new','0','0',now(),now());

INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','DB','Oracle','7.0','Oracle 7.0','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','DB','Mysql','7.0','Oracle 7.0','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','DB','SQL','1.0','ANSI SQL','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','DB','H2','2.0','H2 SQL','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','DB','Hsqldb','2.3.4','Hsqldb SQL','r1','new','0','0',now(),now());

INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','Framework','Spring','4.2','Spring framework','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','Framework','Vert.x','3.0','Vert.x framework','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','Framework','Gradle','4.2','Gradle framework','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','Framework','Maven','3.7','Maven framework','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','Framework','Git','3.0','Git framework','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','Framework','Genkins','3.7','Genkins framework','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','Framework','Cocos2d','3.7','Cocos2d framework','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','Framework','Mybatis','3.7','Mybatis framework','r1','new','0','0',now(),now());
INSERT INTO abilists.m_tech (mt_skill,mt_kind,mt_name,mt_version,mt_explain,mt_relation,mt_trend,mt_status,mt_delete,insert_time,update_time) VALUES ('skills','Framework','Hibernate','3.7','Hibernate framework','r1','new','0','0',now(),now());
