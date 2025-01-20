# Dev

```
bin/rails server
```

# Build

```
docker build --platform=linux/amd64 -t aweist/sample-request-service .
```

### push

```
docker push aweist/sample-request-service
```

### deploy via docker compose

```docker
  lmnt:
    image: aweist/lmnt:latest
    environment:
      - PORT=3001
      - SHOPIFY_STOREFRONT_API_TOKEN={redacted}
      - SAMPLE_REQUEST_SERVICE_URL=http://localhost:3000
    ports:
      - "3001:3001"
    network_mode: "host"
```
