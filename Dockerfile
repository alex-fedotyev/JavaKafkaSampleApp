# Download latest java agent
FROM alpine:3.9 as JAVA
WORKDIR /agent
RUN apk --no-cache add curl
RUN curl -L "https://oss.sonatype.org/service/local/artifact/maven/redirect?r=snapshots&g=co.elastic.apm&a=elastic-apm-agent&v=LATEST" -o elastic-apm-agent.jar

# Download latest node.js agent
FROM node:8 as NODEJS
WORKDIR /agent
RUN npm install elastic-apm-node --save

# Download latest java agent
FROM alpine:3.9 as DOTNET
WORKDIR /agent
RUN apk --no-cache add curl
RUN curl -L "https://github.com/elastic/apm-agent-dotnet/releases/download/1.7.0-beta1/ElasticApmAgent_1.7.0beta1.zip" -o agent.zip
RUN unzip agent.zip
RUN rm agent.zip


# Copy all agents binaires to the final image of Elastic APM agent container
FROM alpine:3.9 as FINAL

# Java agent
RUN mkdir -p /opt/Elastic/agents/java
COPY --from=JAVA /agent/elastic-apm-agent.jar /opt/Elastic/agents/java/

# Node.js agent
RUN mkdir -p /opt/Elastic/agents/nodejs/node_modules
COPY --from=NODEJS /agent/node_modules/ /opt/Elastic/agents/nodejs/node_modules/
COPY elastic-agent.js /opt/Elastic/agents/nodejs/

# .NET agent
RUN mkdir -p /opt/Elastic/agents/dotnet
COPY --from=DOTNET /agent/ /opt/Elastic/agents/dotnet/
