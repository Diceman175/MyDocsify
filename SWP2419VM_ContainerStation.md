# SWP2419VM | Contasiner Station  | Installation & Configuration Notes

* [SWP2419VM](SWP2419VM.md)

https://thelinuxcode.com/setup_git_http_server_docker/

### Prerequisites
Install Web Station
	https://swp2419vm.synology.me/


Create git volume

"alpine/git"
	A simple git container running in alpine linux, especially for tiny linux distro.
	https://hub.docker.com/r/alpine/git/

"gitlab/gitlab-ce"
	GitLab Community Edition docker image based on the Omnibus package
	https://hub.docker.com/r/gitlab/gitlab-ce/

"jwilder/docker-gen"
	A file generator that renders templates using docker container meta-data.
	https://hub.docker.com/r/jwilder/docker-gen/

"jwilder/nginx-proxy"
	Automated Nginx reverse proxy for docker containers
	https://hub.docker.com/r/jwilder/nginx-proxy/

"nginx"
	Official build of Nginx.
	https://hub.docker.com/_/nginx/


"squidfunk/mkdocs-material"
	Write documentation in Markdown and create a professional static site for your Open Source or commercial project in minutes – searchable, customizable, more than 50 languages, for all devices
	https://hub.docker.com/r/squidfunk/mkdocs-material/

docsify
  FROM node:latest
  LABEL description="Docsify."
  WORKDIR /docs
  RUN npm install -g docsify-cli@latest
  EXPOSE 3000/tcp
  ENTRYPOINT docsify serve 

 3000
 35729