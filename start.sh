#리눅스 서버 실행용
sudo rm nohup.out 
git pull
npm install
npx tsc
rsync -av --exclude '*.ts' ./src/ ./bin/
node bin/server.js
