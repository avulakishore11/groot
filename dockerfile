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
# RUN useradd -ms /bin/bash azureuser

# set the working directory
WORKDIR /app

# set the permissions for the azureuser
# RUN chgrp -R 0 /home/azureuser && \
    # chmod -R g=u /home/azureuser 

# copy the jar file from the Build stage. 
COPY --from=builder /app ./

# exposing the application port

EXPOSE 8080

# change the azureuser

# USER azureuser

# run the application

# CMD [" "java", "-jar", "groot.jar"]

