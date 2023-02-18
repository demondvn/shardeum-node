FROM registry.gitlab.com/shardeum/server:latest

ARG RUNDASHBOARD=y
ENV RUNDASHBOARD=${RUNDASHBOARD}

RUN apt update && apt-get install -y sudo git
RUN npm i -g pm2
RUN git clone https://gitlab.com/shardeum/validator/cli.git && cd cli &&  npm i --silent && npm link
RUN git clone https://gitlab.com/shardeum/validator/gui.git && cd gui && npm i --silent &&  npm run build
# Create node user
RUN usermod -aG sudo node && \ 
 echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
 chown -R node /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share 



# Copy cli src files as regular user
WORKDIR /home/node/app
COPY --chown=node:node . .
RUN chown -R node /home/node /home/node/app 
RUN ln -s /usr/src/app /home/node/app/validator
# RUN ln -s /usr/src/app /home/node/app/validator
USER node
# Start entrypoint script as regular user
CMD ["./entrypoint.sh"]
