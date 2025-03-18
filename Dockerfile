# Base image로 openjdk 17을 사용
FROM openjdk:17-jdk-slim

# JAR 파일을 컨테이너로 복사
COPY ./build/libs/dockertest-0.0.1-SNAPSHOT.jar /app.jar

# 8080 포트 열기 (스프링 부트 기본 포트)
EXPOSE 8080

ARG DEBUG=false
ENV DEBUG=${DEBUG}

# 컨테이너에서 애플리케이션 실행
#ENTRYPOINT ["java", "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005","-jar","/app.jar"]
ENTRYPOINT ["sh", "-c", "if [ \"$DEBUG\" = \"true\" ]; then java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005 -jar /app.jar; else java -jar /app.jar; fi"]