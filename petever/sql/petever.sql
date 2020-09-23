--=================================
-- 관리자(system) 계정
--=================================
create user petever 
identified by petever
default tablespace users;

grant resource, connect to petever;


------------------------------ 
-- 테이블 생성
------------------------------
CREATE TABLE "user" (
	user_id	VARCHAR2(30)	NOT NULL,
	user_pwd	VARCHAR2(300)	NOT NULL	,
	user_email	VARCHAR2(100)	NOT NULL,
	user_birth_date	VARCHAR2(8)	NOT NULL	,
	user_phone	 VARCHAR2(11)	NOT NULL,
	user_local	VARCHAR2(40)	NOT NULL,
	user_role	CHAR(1) default 'U' NOT NULL,
    constraints pk_user_id primary key(user_id),
    constraints ck_user_role check(user_role in ('U','A')) 
);


--CREATE TABLE message (
--	msg_num	NUMBER	NOT NULL,
--	user_id	VARCHAR2(30)	NOT NULL,
--	user_id_send	VARCHAR2(30)	NOT NULL,
--	msg_content	VARCHAR2(2000) NOT NULL,
--	msg_time	DATE	 default sysdate,
--    constraint pk_msg_num primary key (msg_num, user_id),
--    constraint fk_msg_user_id foreign key(user_id)
--                                    references "user"(user_id)
--);

CREATE TABLE animal_board (
	ani_bo_id	NUMBER	NOT NULL	,
	user_id	VARCHAR2(30)	NOT NULL	,
	ani_bo_title	VARCHAR(200)	NOT NULL,
	ani_bo_content	VARCHAR2(3000)	NOT NULL	,
	ani_bo_date DATE default sysdate,
	ani_bo_tag VARCHAR2(30)	NOT NULL,
	ani_bo_local	VARCHAR2(1000)	NOT NULL,
   	ani_bo_type	VARCHAR2(20)	,
	ani_bo_kind	VARCHAR2(50)	,
	ani_bo_gender	 VARCHAR2(10)	,
	ani_bo_age	VARCHAR2(20)	,
	ani_bo_size	VARCHAR2(20)	,
	ani_bo_hair	VARCHAR2(50)	,
	ani_bo_color	VARCHAR2(50)	,
	ani_bo_cha VARCHAR2(500)	,
	ani_bo_miss_date	VARCHAR2(50),
    constraints pk_ani_bo_id primary key(ani_bo_id),
    constraints fk_ani_bo_user_id foreign key(user_id)
                                    references "user"(user_id)
                                    on delete cascade
                           
);

CREATE TABLE animal_attach (
	ani_at_id	 NUMBER	NOT NULL,
	ani_bo_id 	NUMBER	NOT NULL,
	ani_at_original_name	VARCHAR2(300)	NULL	,
	ani_at_renamed_name	VARCHAR2(300)	NULL	,
	ani_at_upload_date DATE	default sysdate,
    constraints pk_ani_at_id primary key(ani_at_id, ani_bo_id),
    constraints fk_at_ani_bo_id foreign key(ani_bo_id)
                                    references animal_board(ani_bo_id)
                                    on delete cascade
);



CREATE TABLE animal_comment (
	ani_co_id	NUMBER	NOT NULL	,
	ani_bo_id	NUMBER	NOT NULL	,
	user_id	VARCHAR2(30)	NOT NULL	,
	ani_co_content	VARCHAR(1000)	NOT NULL	,
	ani_co_level 	NUMBER default 1	NOT NULL	,
	ani_co_date	 DATE default sysdate,
    constraints pk_ani_co_id primary key(ani_co_id,ani_bo_id),
    constraints fk_co_ani_bo_id foreign key(ani_bo_id)
                                    references animal_board(ani_bo_id)
                                    on delete cascade,
    constraints fk_co_user_id foreign key(user_id)
                                    references "user"(user_id)
                                    on delete cascade,
    constraints ck_ani_co_level check (ani_co_level in('1','2'))
);

CREATE TABLE animal_tag (
	tag_ID NUMBER,
	tag_color VARCHAR2(100)	NOT NULL	,
	tag_font VARCHAR2(30)	NOT NULL	,
	tag_pet_name	VARCHAR2(50)	NOT NULL	,
	tag_birth_date	VARCHAR2(50),
	tag_gender	VARCHAR2(30),
	tag_num NUMBER,
	tag_family_name	VARCHAR2(50)	NOT NULL,
	tag_family_phone VARCHAR2(20)	NOT NULL,
     constraints pk_tag_id primary key(tag_ID)
);


CREATE TABLE review_board (
	rew_bo_id	NUMBER,
	user_id	VARCHAR2(30)	NOT NULL	,
	rew_bo_title	VARCHAR(200)	NOT NULL	,
	rew_bo_content	VARCHAR2(2000)	NOT NULL	,
	rew_bo_reg_date	DATE default sysdate,
    constraints pk_rew_bo_id primary key(rew_bo_id),
    constraints fk_rew_user_id foreign key(user_id)
                                    references "user"(user_id)
                                    on delete cascade
);

CREATE TABLE review_comment (
	rew_co_id	NUMBER	NOT NULL	,
	rew_bo_id	NUMBER	NOT NULL	,
	user_id	VARCHAR2(30)	NOT NULL,
	rew_co_content	VARCHAR(2000)	NOT NULL	,
	rew_co_level	NUMBER default 1	NOT NULL	,
	rew_co_date	DATE	 default sysdate,
    constraints pk_rew_co_id primary key(rew_co_id,rew_bo_id),
    constraints fk_com_rew_bo_id foreign key(rew_bo_id)
                                    references review_board(rew_bo_id)
                                    on delete cascade,
    constraints fk_rew_co_user_id foreign key(user_id)
                                    references "user"(user_id)
                                    on delete cascade,
    constraints ck_rew_co_level check (rew_co_level in('1','2'))
);

CREATE TABLE review_attach (
	rew_at_id	NUMBER,
	rew_bo_id	NUMBER NOT NULL,
	rew_at_original_name	VARCHAR2(300)	NULL,
	rew_at_renamed_name	VARCHAR2(300)	NULL,
	rew_at_upload_date 	DATE default sysdate,
    constraints pk_rew_at_id primary key(rew_at_id, rew_bo_id),
    constraints fk_at_rew_bo_id foreign key(rew_bo_id)
                                    references review_board(rew_bo_id)
                                    on delete cascade
);

CREATE TABLE Report (
	ani_bo_id	NUMBER,
	user_id	VARCHAR2(30),
	rep_content	VARCHAR2(1000),
	rep_display	CHAR(1) default 'Y' not null,
	rep_date	DATE	 default sysdate,
	rep_do_user	VARCHAR2(30)	NOT NULL,
    constraints pk_rep_ani_bo_id primary key(ani_bo_id),
    constraints fk_rep_ani_bo_id foreign key(ani_bo_id)
                                        references animal_board(ani_bo_id)
                                        on delete cascade,
    constraints fk_rep_user_id foreign key(user_id)
                                        references "user"(user_id)
                                        on delete cascade,
    constraints ck_rep_display check(rep_display in('Y','N'))
);
drop table statis;
create table statis(
    no number,
    kind varchar(7),
    state varchar(20),
    org varchar(50),
    careaddr varchar(50),
    beginday varchar(50),
    endday varchar(50),
    filename varchar(100)
);

create sequence seq_statis_no;
