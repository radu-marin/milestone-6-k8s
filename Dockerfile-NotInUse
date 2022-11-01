FROM hashicorp/terraform

WORKDIR /

COPY . .

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG ENV
#ARG ACTION

WORKDIR /live/${ENV}

RUN export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
RUN export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
#sadly the credentials are not obscured, check https://stackoverflow.com/questions/68013550/docker-how-to-hide-build-arguments
RUN terraform init
RUN terraform plan -out=plan

#disable entrypoint
ENTRYPOINT [""]


# If used, this Dockerfile, should be followed by cmds like:
#docker build --build-arg AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID --build-arg AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY --build-arg ENV="DEV/EKS" . -t terraform-img
#docker run -i -t terraform-img terraform show plan
