# Base image to build and publsih the artifact
FROM maven:3.9.8-eclipse-temurin-11 AS builder 

# sets up working directory

WORKDIR /app

# copy the all maven dependencies 



# copy the rest of source code

COPY . .

# build the actual application once its copies the entire code inot container

RUN mvn clean package

# stage: 2 create the runtime image

FROM eclipse-temurin:11-jre

# set up the user
RUN useradd -ms /bin/bash cloud_user

# set the working directory
WORKDIR /app

# set the permissions for the azureuser
 RUN chgrp -R 0 /home/cloud_user && \
 chmod -R g=u /home/cloud_user 

# copy the jar file from the Build stage. 
# writng this making trouble to run the iamge COPY --from=builder /app ./

# Copy the built JAR only
# COPY --from=builder /app/target/*.jar app.jar

COPY --from=builder /app/target/groot-4.0.4-SNAPSHOT-jar-with-dependencies.jar app.jar


# exposing the application port

EXPOSE 8080

# change the azureuser

# USER azureuser

# run the application

CMD ["java", "-jar", "groot.jar"]

