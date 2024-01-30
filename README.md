# About
Build a docker image in order to run or deploy a shiny web application for outliers detection through classical and robust pca.

# Description
1. Download the 2 files (Dockerfile and app.R) in the same directory    
2. Build the docker image in terminal with the command: `docker build -t image_name .`
3. Run the container image in the terminal with the command: `docker run --rm -dp 3838:3838 --name container_name image_name`
4. Stop the running container with the command: `docker stop container_name`
