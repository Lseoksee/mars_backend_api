import * as mysql from "mysql";
import * as fs from "fs";
const serverset = JSON.parse(fs.readFileSync("server.json", "utf-8"));

function gettest() {
    const query = `SELECT id, passwd from User;`;

    const dbconect = mysql.createConnection(serverset.setdb);
    dbconect.connect();

    dbconect.query(query, (err: mysql.MysqlError, results?: any[]) => {
        results?.forEach((line) => {
            console.log(line);
        });
        if (err) {
            console.log(err);
        }
    });

    dbconect.end();
}

async function settest(url: string) {
    const user_name = "관리자1";
    const value = 50;

    const response = await fetch(`http://korseok.kro.kr/api/${url}`, {
        method: "post",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({
            user_name: user_name,
            value: value,
        }),
    });

    const res = await response.json();
    console.log(res);
}

settest("setlife");
