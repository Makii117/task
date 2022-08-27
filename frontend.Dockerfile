FROM node
RUN mkdir -p /data
WORKDIR /data

RUN git clone https://github.com/kkenan/basic-microservices.git 

WORKDIR /data/basic-microservices/node-app/

ENV PORT=8081  
   
EXPOSE 8081



RUN ["npm","install"]

CMD ["node", "index.js"]