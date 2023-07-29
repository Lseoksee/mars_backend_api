/* 목표/스킬트리 */
import express = require("express");
import mysql = require("mysql");
import { TypedRequestBody, sameobj, serverset } from "../server";
const mark = express.Router();

// 스킬 트리 리턴
mark.get("/getskilltree/:tartget_mark", (req, res) => {
    const query = `select skill_field, skill_level from Skill_Mark 
    where target_mark = "${req.params.tartget_mark}"
    order by skill_level;`;

    const dbconect = mysql.createConnection(serverset.setdb);
    dbconect.connect();

    dbconect.query(query, (err: mysql.MysqlError, results?: any[]) => {
        if (err) {
            console.error(err);
            res.status(500).json({ err: err.code });
        } else {
            if (!results?.length) {
                console.error("항목없음");
                res.status(500).json({ err: "empty" });
            } else {
                res.json({ results });
            }
        }
    });

    dbconect.end();
});


// 세부 목록 리턴 스킬명(목표명/레벨): [{mark_id, mark_list}]
mark.get("/getdetailmark/:skill/:level", (req, res) => {
    const query = `select mark_id, mark_list from Details_mark 
    where skill_field = "${req.params.skill}" && level = ${req.params.level}
    order by target_mark, level;`;

    const dbconect = mysql.createConnection(serverset.setdb);
    dbconect.connect();

    dbconect.query(query, (err: mysql.MysqlError, results?: any[]) => {
        if (err) {
            console.error(err);
            res.status(500).json({ err: err.code });
        } else {
            if (!results?.length) {
                console.error("항목없음");
                res.status(500).json({ err: "empty" });
            } else {
                res.json({ results });
            }
        }
    });

    dbconect.end();
});

// 유저 선택 스킬트리 (닉네임): skills: [...스킬들]
mark.get("/getuserskill/:name", (req, res) => {
    const query = `select skill_field from User_skill where user_name = "${req.params.name}";`;

    const dbconect = mysql.createConnection(serverset.setdb);
    dbconect.connect();

    dbconect.query(query, (err: mysql.MysqlError, results?: any[]) => {
        if (err) {
            console.error(err);
            res.status(500).json({ err: err.code });
        } else {
            if (!results?.length) {
                console.error("항목없음");
                res.status(500).json({ err: "empty" });
            } else {
                results = results.map((line) => {
                    return line.skill_field;
                });

                res.json({ results });
            }
        }
    });

    dbconect.end();
});

// 사용자 목표 현황 (이름/스킬명/레벨): [{mark_id, progress, date}]
mark.get("/getusermark/:user_name/:skill/:level", (req, res) => {
    const query = `select Details_mark.mark_id, User_mark.progress, User_mark.date from User_mark 
    join Details_mark on User_mark.mark_id = Details_mark.mark_id
    where User_mark.user_name = "${req.params.user_name}" && 
    Details_mark.skill_field = "${req.params.skill}" && 
    Details_mark.level = ${req.params.level};`;

    const dbconect = mysql.createConnection(serverset.setdb);
    dbconect.connect();

    dbconect.query(query, (err: mysql.MysqlError, results?: any[]) => {
        if (err) {
            console.error(err);
            res.status(500).json({ err: err.code });
        } else {
            if (!results?.length) {
                console.error("항목없음");
                res.status(500).json({ err: "empty" });
            } else {
                res.json({ results });
            }
        }
    });

    dbconect.end();
});

// 세부목표 추가 정보사항 유튜브 링크 같은거(세부목표 id): [추가정보들] or err
mark.get("/getmoredata/:mark_id", (req, res) => {
    const query = `select info_data from More_data where mark_id = ${req.params.mark_id};`;

    const dbconect = mysql.createConnection(serverset.setdb);
    dbconect.connect();

    dbconect.query(query, (err: mysql.MysqlError, results?: any[]) => {
        if (err) {
            console.error(err);
            res.status(500).json({ err: err.code });
        } else {
            if (!results?.length) {
                console.error("항목없음");
                res.status(500).json({ err: "empty" });
            } else {
                results = results.map((line) => {
                    return line.info_data;
                });

                res.json({ results });
            }
        }
    });

    dbconect.end();
});

// 사용자 진행 목표 설정 (닉네임, 세부목표id, 진행도): err: ER_DUP_ENTRY or ok
type setuserskill = {
    user_name: string; // 닉네임
    mark_id: number; // 세부 목표 id  
    progress: number; // 진행도
};
const setuserskill = {
    user_name: "string",
    mark_id: "int",
    progress: "int",
};
mark.post("/setuserskill", (req: TypedRequestBody<setuserskill>, res) => {
    if (!sameobj(setuserskill, req.body)) {
        console.error("값이 잘못넘어옴");
        res.status(500).json({ err: "type_err", type: setuserskill });
        return;
    }
    const query = `insert into User_mark (user_name, mark_id, progress) 
    values ("${req.body.user_name}", "${req.body.mark_id}", "${req.body.progress}") on duplicate key update 
    user_name = "${req.body.user_name}", 
    mark_id="${req.body.mark_id}", 
    progress = "${req.body.progress}",
    date = current_date();`;

    const dbconect = mysql.createConnection(serverset.setdb);
    dbconect.connect();

    dbconect.query(query, (err: mysql.MysqlError, results?: any[]) => {
        if (err) {
            console.error(err);
            res.status(500).json({ err: err.code });
        } else {
            res.json({ results: true });
        }
    });

    dbconect.end();
});

export default mark;
