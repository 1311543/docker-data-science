FROM ubuntu
RUN apt-get update && yes|apt-get update
RUN apt-get install -y wget bzip2
RUN wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
RUN bash Anaconda3-5.0.1-Linux-x86_64.sh -b
RUN rm Anaconda3-5.0.1-Linux-x86_64.sh
ENV PATH /root/anaconda3/bin:$PATH
RUN conda update conda -y && \
            conda update anaconda -y && \
            conda update --all
RUN mkdir /opt/notebooks
EXPOSE 8888
CMD ["jupyter", "notebook", "--allow-root", "--notebook-dir=/opt/notebooks", "--ip='*'", "--port=8888", "--no-browser"]

#docker build -t friendlyhello .  # Create image using this directory's #Dockerfile
#docker run -p 4000:80 friendlyhello  # Run "friendlyname" mapping port 4000 to 80
#docker run -d -p 4000:80 friendlyhello         # Same thing, but in detached mode
#docker container ls                                # List all running containers
#docker container ls -a             # List all containers, even those not running
#docker container stop <hash>           # Gracefully stop the specified container
#docker container kill <hash>         # Force shutdown of the specified container
#docker container rm <hash>        # Remove specified container from this machine
#docker container rm $(#docker container ls -a -q)         # Remove all containers
#docker image ls -a                             # List all images on this machine
#docker image rm <image id>            # Remove specified image from this machine
#docker image rm $(#docker image ls -a -q)   # Remove all images from this machine
#docker login             # Log in this CLI session using your #Docker credentials
#docker tag <image> username/repository:tag  # Tag <image> for upload to registry
#docker push username/repository:tag            # Upload tagged image to registry
#docker run username/repository:tag                   # Run image from a registry