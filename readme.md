Builds libsodium.js using `emsdk` sdk-latest-64bit

Instructions to run locally:

```
docker build -t libsodiumjs .
docker create --name libsodiumjs libsodiumjs
docker cp libsodiumjs:/libsodium.js/dist/ .
```

The built files should be in `./dist`
