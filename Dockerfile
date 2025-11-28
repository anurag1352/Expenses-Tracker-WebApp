# Stage-1 --build JAR (Java Application RunTime)

FROM maven:3.8.3-openjdk-17 AS builder 

WORKDIR /app

COPY . .

# Install application & Skip Test Cases.
RUN  mvn clean install -DskipTests=true

# Stage-2 execute the JAR file from the above stage.

FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

COPY --from=builder /app/target/*.jar /app/target/expenseapp.jar

EXPOSE 8000

CMD ["java", "-jar", "/app/target/expenseapp.jar"]
