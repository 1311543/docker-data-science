FROM ubuntu

MAINTAINER francis de la cruz :v1

RUN apt-get update && yes|apt-get update
RUN apt-get install -y wget bzip2        
#RUN apt-get install -y wget bzip2

RUN wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh

RUN bash Anaconda3-5.0.1-Linux-x86_64.sh -b
RUN rm Anaconda3-5.0.1-Linux-x86_64.sh

ENV PATH /root/anaconda3/bin:$PATH
RUN conda update conda  
RUN conda update anaconda 
RUN conda update --all
RUN mkdir /opt/notebooks

RUN jupyter notebook --generate-config --allow-root
RUN echo "c.NotebookApp.certfile = u'/absolute/path/to/your/certificate/fullchain.pem'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.keyfile = u'/absolute/path/to/your/certificate/privkey.pem'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.ip = '*'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.password = u'sha1:67c9e60bb8b6:9ffede0825894254b2e042ea597d771089e11aed'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.open_browser = False'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.keyfile = u'/absolute/path/to/your/certificate/privkey.pem'" >> /root/.jupyter/jupyter_notebook_config.py



WORKDIR /opt/notebooks
ADD ./Jupiter_notebooks* /opt/notebooks
# ACCEDER DESDE FUERA DEL CONTAINER
EXPOSE  
CMD ["jupyter", "notebook", "--allow-root", "--notebook-dir=/opt/notebooks", "--ip='*'", "--port=8888", "--no-browser"]


# formas de exponer tu container
#  docker run --rm -it -p 8888 anaconda_v6
# localhost:(docker ps) / 0.0.0.0:(autogerado), 8888 es igual al del docker file

#  docker run --rm -it -p 8000:8888 anaconda_v6
# localhost:8000

#  docker run --rm -it -P anaconda_v6 (te autogeneera)

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
#docker container prune	Remove all stopped containers


#  docker build -t anaconda_v1:latest /home/francis/Escritorio/AnacondaDockerfile

#  docker build -t anaconda_v1:latest --volume anaconda \
# /home/francis/Proyectos/DockerFIles/docker-data-science

# --rm		Automatically remove the container when it exits
# docker run --name anaconda_v1:latest --rm -it -p 80 docker build -t anaconda_v5:latest
#docker run --rm -it -p anaconda_v5:latest

#docker run -d --name unkkuri-odoo --link unkkuri-db:db -p 8069:8069 \
 # --network unkkuri-odoo-nw \
 # --mount source=unkkuri-odoo-data,target=/var/lib/odoo \
 # --mount source=unkkuri-odoo-extra-addons,target=/mnt/extra-addons \
 # --env POSTGRES_PASSWORD=unkkuri-secret-pw \odoo:11.0

  docker run --rm -it -P \
  --name anaconda_v1:latest \
  --mount source=anaconda,target=/home/francis/Proyectos/DockerFIles/docker-data-science/app \
  data_science_anaconda