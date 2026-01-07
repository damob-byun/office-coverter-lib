# office-converter-lib
## 라이브러리 파일

- SO파일 
- bin파일안의 .zip를 모두 .so로 변경



## Installation

```bash
#라이브러리 설치
sudo apt install -y openjdk-8-jdk
#sudo update-alternatives --config java
#readlink -f $(which java)
sudo apt-get install -y unzip
sudo apt-get install -y imagemagick 
sudo apt-get install -y libharfbuzz-dev
sudo apt-get install -y build-essential
# tmp 파일 하루에 한번 정리
sudo apt install tmpreaper 
# .zip to .so
cd ~/office-coverter-lib/bin
unzip '*.zip'
sudo mkdir -p /usr/java/packages/
cd /usr/java/packages/
sudo ln -s ~/office-coverter-lib/bin/ /usr/java/packages/lib
#폰트설치
sudo apt install fontconfig
cd ~/office-coverter-lib
sudo cp -r font/* /usr/share/fonts/
sudo chown -R root:root /usr/share/fonts/
sudo fc-cache -f -v
#아파치 설치
cd ~
wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.113/bin/apache-tomcat-9.0.113.tar.gz
tar xvzf apache-tomcat-9.0.113.tar.gz
ln -s apache-tomcat-9.0.113 current_tomcat
#sudo vi /etc/sysctl.conf에서 fs.file-max=372738 수정
sysctl -p
#sudo vi /etc/security/limits.conf 수정
#* soft nproc 65535
#* hard nproc 65535
#* soft nofile 65535
#* hard nofile 65535
# cat ./bash.rc -> 배쉬값을 catailna 최상단에 넣기(home/ubuntu 부분 해당 유저이름으로 수정)
cat ~/office-coverter-lib/bash.rc | tee -a ~/current_tomcat/bin/setenv.sh
# current_tomcat 기본 삭제
rm -r ~/current_tomcat/webapps/*
# office convert 빌드된거 집어 넣기(release에 있음)
#cd ~/office-coverter
#./gradlew bootWar
cp ~/office-coverter/build/libs/hwp-0.0.1-SNAPSHOT.war ~/current_tomcat/webapps/
mv ~/current_tomcat/webapps/hwp-0.0.1-SNAPSHOT.war ~/current_tomcat/webapps/ROOT.war

# /home/ubuntu /home/유저이름 으로 수정
sudo nano ~/office-coverter-lib/tomcat.service
# hnc 복사 (sdk 실행용)
sudo cp -r ./office-coverter-lib/hnc /root/
# service 실행
sudo cp -r ~/office-coverter-lib/tomcat.service /etc/systemd/system/
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable tomcat.service
sudo systemctl start tomcat.service
```

