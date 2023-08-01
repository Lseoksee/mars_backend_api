CREATE DATABASE mars;

USE mars;

CREATE TABLE `User` (
	`id`	varchar(100)	NOT NULL,
	`passwd`	varchar(100)	NOT NULL
);

CREATE TABLE `User_data` (
	`user_name`	varchar(100)	NOT NULL,
	`user_id`	varchar(100)	NOT NULL,
	`choice_mark`	varchar(100)	NOT NULL	COMMENT '프로그래밍, 등산',
	`user_title`	varchar(100)	NULL,
	`profile_local`	varchar(100)	NOT NULL	COMMENT '유저 프사 경로',
	`life`	int	NOT NULL,
	`money`	int	NOT NULL,
	`level`	int	NOT NULL
);

CREATE TABLE `User_Title` (
	`user_title`	varchar(100)	NOT NULL
);

CREATE TABLE `Mark_list` (
	`mark`	varchar(100)	NOT NULL	COMMENT '프로그래밍, 등산',
	`type`	varchar(100)	NOT NULL	COMMENT '공부, 운동'
);

CREATE TABLE `User_skill` (
	`user_name`	varchar(100)	NOT NULL,
	`skill_field`	varchar(100)	NOT NULL	COMMENT 'html css...'
);

CREATE TABLE `User_avatar` (
	`user_name`	varchar(100)	NOT NULL,
	`look`	varchar(100)	NOT NULL,
	`color`	varchar(100)	NOT NULL,
	`shop_element1`	int	NULL
);

CREATE TABLE `User_friend` (
	`user_name`	varchar(100)	NOT NULL,
	`friend`	varchar(100)	NOT NULL
);

CREATE TABLE `Shop_item` (
	`object_id`	int	NOT NULL	COMMENT '순차부여',
	`type`	varchar(100)	NOT NULL	COMMENT '아이템 타입',
	`item_name`	varchar(100)	NOT NULL,
	`local`	varchar(100)	NOT NULL	COMMENT '모델 경로',
	`price`	int	NOT NULL
);

CREATE TABLE `Skill_Mark` (
	`skill_field`	varchar(100)	NOT NULL	COMMENT 'html, css...',
	`target_mark`	varchar(100)	NOT NULL	COMMENT '프로그래밍, 등산',
	`skill_level`	int	NOT NULL
);

CREATE TABLE `Details_mark` (
	`mark_id`	int	NOT NULL	COMMENT '순차부여',
	`target_mark`	varchar(100)	NOT NULL	COMMENT '프로그래밍, 등산',
	`skill_field`	varchar(100)	NOT NULL	COMMENT 'html, css...',
	`mark_list`	varchar(100)	NOT NULL	COMMENT '세부 목표들',
	`level`	int	NOT NULL
);

CREATE TABLE `User_mark` (
	`user_name`	varchar(100)	NOT NULL,
	`mark_id`	int	NOT NULL,
	`progress`	int	NOT NULL,
	`date`	date	NOT NULL
);

CREATE TABLE `User_space` (
	`user_name`	varchar(100)	NOT NULL,
	`element1`	int	NULL,
	`element2`	int	NULL
);

CREATE TABLE `User_bluetooth` (
	`user_name`	varchar(100)	NOT NULL,
	`bt_mac`	varchar(100)	NOT NULL
);

CREATE TABLE `More_data` (
	`info_data`	varchar(100)	NOT NULL,
	`mark_id`	int	NOT NULL
);

CREATE TABLE `VR_exam` (
	`exam_id`	int	NOT NULL	COMMENT '순차부여',
	`target_mark`	varchar(100)	NOT NULL	COMMENT '프로그래밍, 등산',
	`skill_field`	varchar(100)	NOT NULL	COMMENT 'html, css...',
	`exam`	varchar(100)	NOT NULL,
	`correct`	varchar(100)	NOT NULL,
	`rate`	int	NOT NULL
);

CREATE TABLE `VR_exam_option` (
	`exam_option`	varchar(100)	NOT NULL	COMMENT '4지선다',
	`exam_id`	int	NOT NULL
);

CREATE TABLE `VR_exam_stat` (
	`user_name`	varchar(100)	NOT NULL,
	`exam_id`	int	NOT NULL	COMMENT '순차부여',
	`is_correct`	int	NOT NULL	COMMENT '정답=100, 오답=0'
);

ALTER TABLE `User` ADD CONSTRAINT `PK_USER` PRIMARY KEY (
	`id`
);

ALTER TABLE `User_data` ADD CONSTRAINT `PK_USER_DATA` PRIMARY KEY (
	`user_name`
);

ALTER TABLE `User_Title` ADD CONSTRAINT `PK_USER_TITLE` PRIMARY KEY (
	`user_title`
);

ALTER TABLE `Mark_list` ADD CONSTRAINT `PK_MARK_LIST` PRIMARY KEY (
	`mark`
);

ALTER TABLE `User_skill` ADD CONSTRAINT `PK_USER_SKILL` PRIMARY KEY (
	`user_name`,
	`skill_field`
);

ALTER TABLE `User_avatar` ADD CONSTRAINT `PK_USER_AVATAR` PRIMARY KEY (
	`user_name`
);

ALTER TABLE `User_friend` ADD CONSTRAINT `PK_USER_FRIEND` PRIMARY KEY (
	`user_name`, 
	`friend`
);

ALTER TABLE `Shop_item` ADD CONSTRAINT `PK_SHOP_ITEM` PRIMARY KEY (
	`object_id`
);

ALTER TABLE `Skill_Mark` ADD CONSTRAINT `PK_SKILL_MARK` PRIMARY KEY (
	`skill_field`,
	`target_mark`
);

ALTER TABLE `Details_mark` ADD CONSTRAINT `PK_DETAILS_MARK` PRIMARY KEY (
	`mark_id`
);

ALTER TABLE `User_mark` ADD CONSTRAINT `PK_USER_MARK` PRIMARY KEY (
	`user_name`,
	`mark_id`
);

ALTER TABLE `User_space` ADD CONSTRAINT `PK_USER_SPACE` PRIMARY KEY (
	`user_name`
);

ALTER TABLE `User_bluetooth` ADD CONSTRAINT `PK_USER_BLUETOOTH` PRIMARY KEY (
	`user_name`
);

ALTER TABLE `More_data` ADD CONSTRAINT `PK_MORE_DATA` PRIMARY KEY (
	`info_data`,
	`mark_id`
);

ALTER TABLE `VR_exam` ADD CONSTRAINT `PK_VR_EXAM` PRIMARY KEY (
	`exam_id`
);

ALTER TABLE `VR_exam_option` ADD CONSTRAINT `PK_VR_EXAM_OPTION` PRIMARY KEY (
	`exam_option`,
	`exam_id`
);

ALTER TABLE `VR_exam_stat` ADD CONSTRAINT `PK_VR_EXAM_STAT` PRIMARY KEY (
	`user_name`,
	`exam_id`
);

alter table User_data alter column profile_local set default "default_profile.png";
alter table User_data alter column user_title set default "새싹";
alter table User_data alter column life set default 3;
alter table User_data alter column money set default 0;
alter table User_data alter column level set default 1;

alter table User_mark alter column progress set default 0;
alter table User_mark alter column date set default (current_date);

alter table User_avatar alter column shop_element1 set default NULL;

alter table VR_exam alter column rate set default 0;

alter table Shop_item modify object_id INT NOT NULL AUTO_INCREMENT;

alter table Details_mark modify mark_id INT NOT NULL AUTO_INCREMENT;

alter table VR_exam modify exam_id INT NOT NULL AUTO_INCREMENT;


ALTER TABLE `User_data` ADD CONSTRAINT `FK_User_TO_User_data_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `User` (
	`id`
) on UPDATE CASCADE on DELETE CASCADE;

ALTER TABLE `User_data` ADD CONSTRAINT `FK_Mark_list_TO_User_data_1` FOREIGN KEY (
	`choice_mark`
)
REFERENCES `Mark_list` (
	`mark`
) on UPDATE CASCADE on DELETE CASCADE;

ALTER TABLE `User_data` ADD CONSTRAINT `FK_User_Title_TO_User_data_1` FOREIGN KEY (
	`user_title`
)
REFERENCES `User_Title` (
	`user_title`
) on UPDATE CASCADE on DELETE set NULL;

ALTER TABLE `User_skill` ADD CONSTRAINT `FK_User_data_TO_User_skill_1` FOREIGN KEY (
	`user_name`
)
REFERENCES `User_data` (
	`user_name`
) on UPDATE CASCADE on DELETE CASCADE;

ALTER TABLE `User_skill` ADD CONSTRAINT `FK_Skill_Mark_TO_User_skill_1` FOREIGN KEY (
	`skill_field`
)
REFERENCES `Skill_Mark` (
	`skill_field`
) on UPDATE CASCADE on DELETE CASCADE;

ALTER TABLE `User_avatar` ADD CONSTRAINT `FK_User_data_TO_User_avatar_1` FOREIGN KEY (
	`user_name`
)
REFERENCES `User_data` (
	`user_name`
) on UPDATE CASCADE on DELETE CASCADE;

ALTER TABLE `User_avatar` ADD CONSTRAINT `FK_Shop_item_TO_User_avatar_1` FOREIGN KEY (
	`shop_element1`
)
REFERENCES `Shop_item` (
	`object_id`
) on UPDATE CASCADE on DELETE set NULL;

ALTER TABLE `User_friend` ADD CONSTRAINT `FK_User_data_TO_User_friend_1` FOREIGN KEY (
	`user_name`
)
REFERENCES `User_data` (
	`user_name`
) on UPDATE CASCADE on DELETE CASCADE;

ALTER TABLE `User_friend` ADD CONSTRAINT `FK_User_data_TO_User_friend_2` FOREIGN KEY (
	`friend`
)
REFERENCES `User_data` (
	`user_name`
) on UPDATE CASCADE on DELETE CASCADE;

ALTER TABLE `Skill_Mark` ADD CONSTRAINT `FK_Mark_list_TO_Skill_Mark_1` FOREIGN KEY (
	`target_mark`
)
REFERENCES `Mark_list` (
	`mark`
) on UPDATE CASCADE on DELETE CASCADE;

ALTER TABLE `Details_mark` ADD CONSTRAINT `FK_Skill_Mark_TO_Details_mark_1` FOREIGN KEY (
	`skill_field`
)
REFERENCES `Skill_Mark` (
	`skill_field`
) on UPDATE CASCADE on DELETE CASCADE;

ALTER TABLE `Details_mark` ADD CONSTRAINT `FK_Skill_Mark_TO_Details_mark_2` FOREIGN KEY (
	`target_mark`
)
REFERENCES `Skill_Mark` (
	`target_mark`
) on UPDATE CASCADE on DELETE CASCADE;

ALTER TABLE `User_mark` ADD CONSTRAINT `FK_User_data_TO_User_mark_1` FOREIGN KEY (
	`user_name`
)
REFERENCES `User_data` (
	`user_name`
) on UPDATE CASCADE on DELETE CASCADE;

ALTER TABLE `User_mark` ADD CONSTRAINT `FK_Details_mark_TO_User_mark_1` FOREIGN KEY (
	`mark_id`
)
REFERENCES `Details_mark` (
	`mark_id`
) on UPDATE CASCADE on DELETE CASCADE;

ALTER TABLE `User_space` ADD CONSTRAINT `FK_User_data_TO_User_space_1` FOREIGN KEY (
	`user_name`
)
REFERENCES `User_data` (
	`user_name`
) on UPDATE CASCADE on DELETE CASCADE;

ALTER TABLE `User_space` ADD CONSTRAINT `FK_Shop_item_TO_User_space_1` FOREIGN KEY (
	`element1`
)
REFERENCES `Shop_item` (
	`object_id`
) on UPDATE CASCADE on DELETE set NULL;

ALTER TABLE `User_space` ADD CONSTRAINT `FK_Shop_item_TO_User_space_2` FOREIGN KEY (
	`element2`
)
REFERENCES `Shop_item` (
	`object_id`
) on UPDATE CASCADE on DELETE set NULL;

ALTER TABLE `User_bluetooth` ADD CONSTRAINT `FK_User_data_TO_User_Bluetooth_1` FOREIGN KEY (
	`user_name`
)
REFERENCES `User_data` (
	`user_name`
) on UPDATE CASCADE on DELETE CASCADE;

ALTER TABLE `More_data` ADD CONSTRAINT `FK_Details_mark_TO_More_data_1` FOREIGN KEY (
	`mark_id`
)
REFERENCES `Details_mark` (
	`mark_id`
) on UPDATE CASCADE on DELETE CASCADE;

ALTER TABLE `VR_exam` ADD CONSTRAINT `FK_Skill_Mark_TO_VR_exam_2` FOREIGN KEY (
	`target_mark`
)
REFERENCES `Skill_Mark` (
	`target_mark`
) on UPDATE CASCADE on DELETE CASCADE;

ALTER TABLE `VR_exam_option` ADD CONSTRAINT `FK_VR_exam_TO_VR_exam_option_1` FOREIGN KEY (
	`exam_id`
)
REFERENCES `VR_exam` (
	`exam_id`
) on UPDATE CASCADE on DELETE CASCADE;

ALTER TABLE `VR_exam_stat` ADD CONSTRAINT `FK_User_data_TO_VR_exam_stat_1` FOREIGN KEY (
	`user_name`
)
REFERENCES `User_data` (
	`user_name`
) on UPDATE CASCADE on DELETE CASCADE;

ALTER TABLE `VR_exam_stat` ADD CONSTRAINT `FK_VR_exam_TO_VR_exam_stat_1` FOREIGN KEY (
	`exam_id`
)
REFERENCES `VR_exam` (
	`exam_id`
) on UPDATE CASCADE on DELETE CASCADE;

-- vr 평균 트리거 (insert) 
DELIMITER //
CREATE TRIGGER VR_rate_insert
	AFTER insert
	ON VR_exam_stat
    FOR EACH ROW
BEGIN
	update VR_exam set rate = (select avg(is_correct) from VR_exam_stat where exam_id = new.exam_id) where exam_id = new.exam_id;
END; //
DELIMITER ;

-- vr 평균 트리거 (update)
DELIMITER //
CREATE TRIGGER VR_rate_update
	AFTER update
	ON VR_exam_stat
    FOR EACH ROW
BEGIN
	update VR_exam set rate = (select avg(is_correct) from VR_exam_stat where exam_id = new.exam_id) where exam_id = new.exam_id;
END; //
DELIMITER ;

-- vr 평균 트리거 (delete)
DELIMITER //
CREATE TRIGGER VR_rate_delete
	AFTER delete
	ON VR_exam_stat
    FOR EACH ROW
BEGIN
	update VR_exam set rate = ifnull((select avg(is_correct) from VR_exam_stat where exam_id = old.exam_id), 0) where exam_id = old.exam_id;
END; //
DELIMITER ;