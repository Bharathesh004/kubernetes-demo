FROM node:18-alpine AS base

WORKDIR /app

## Installing dependencies only
COPY package.json package-lock.json* ./
RUN npm ci --omit=dev

## COpying the app source code
COPY . .

USER node
EXPOSE 3000
ENV NODE_ENV=production
CMD ["npm", "start"] 