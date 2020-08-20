FROM cypress/base:10 as TEST
WORKDIR /e2e

# dependencies will be installed only if the package files change
COPY package.json .
COPY package-lock.json .
RUN npm ci

# tests will rerun if the "cypress" folder, "cypress.json" file or "public" folder
# has any changes
# copy tests
COPY cypress cypress
COPY cypress.json .

# by setting CI environment variable we switch the Cypress install messages
# to small "started / finished" and avoid 1000s of lines of progress messages
# https://github.com/cypress-io/cypress/issues/1243
ENV CI=1
RUN npm ci

#Always running E2E tests
ARG BUST=1
# if you run "docker build . --build-arg BUST=$(date +%s)"
# it will bust this cache and it will rerun all commands from here
RUN npm test

# show the size of the current folder so we know
RUN ls -la
RUN du -sh