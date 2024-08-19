FROM node:20-alpine AS build

WORKDIR /app

RUN adduser -S appuser \ 
  && chown appuser ./
  
RUN npm install -g pnpm
    
COPY --chown=appuser package.json pnpm-lock.yaml ./

COPY --chown=appuser . ./

EXPOSE 3000

FROM build AS dev

RUN pnpm i

FROM build AS prod

ENV NODE_ENV=production:true

RUN pnpm i --prod

USER appuser