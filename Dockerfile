FROM registry.gitlab.com/shardeum/server:latest

ARG RUNDASHBOARD=y
ENV RUNDASHBOARD=${RUNDASHBOARD}

RUN apt update && apt-get install -y sudo git
RUN npm i -g pm2

# Create node user
RUN usermod -aG sudo node && \ 
 echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
 chown -R node /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share 



# Copy cli src files as regular user
WORKDIR /node
# RUN chmod 777 -R /home/node /home/node/app 
RUN git clone https://github.com/demondvn/shardeum_cli.git cli && cd cli &&  npm i --silent && npm link
RUN git clone https://gitlab.com/shardeum/validator/gui.git && cd gui && npm i --silent &&  npm run build
COPY entrypoint.sh entrypoint.sh
RUN ln -s /usr/src/app /node/validator
# RUN ln -s gui /home/node/app/gui
# USER node
# Start entrypoint script as regular user
CMD ["./entrypoint.sh"]
