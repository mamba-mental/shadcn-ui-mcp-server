# DOCKERFILE
FROM node:20

WORKDIR /app

# Copy package.json and package-lock.json (if available) first
# This leverages Docker's layer caching. If these files don't change,
# Docker won't re-run npm install unless other files change.
COPY package*.json ./

# Install dependencies. This will also trigger the "prepare" script
# which runs "npm run build" as defined in your package.json.
RUN npm install

# Copy the rest of your application code
COPY . .

# The "prepare" script already ran "npm run build", so build/index.js should exist.
# If you had a separate build step not covered by "prepare", you'd run it here.
# For example: RUN npm run build (if not done by prepare)

EXPOSE 3000

# Use the "start" script defined in package.json
CMD ["npm", "run", "start"]
