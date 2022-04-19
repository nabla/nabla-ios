# Playground

## Getting started

Make your own `User.xcconfig`:

```sh
cp Playground/Configs/User.xcconfig.template Playground/Configs/User.xcconfig
```

Then replace `<nickname>` where needed (your email address is `<nickname>@nabla.com`).

To generate the `PLAYGROUND_API_TOKEN`, log in as an admin on the platform. Go to `Settings` > `API Keys` and generate a new one. Copy the token after `Authorization: Bearer ` and paste it in your `User.xcconfig` file.

If you're working on the simulator, you can target `localhost` and disable the IAP:
```
PLAYGROUND_API_DOMAIN = localhost
PLAYGROUND_API_SCHEME = http
PLAYGROUND_API_PORT = 8080
PLAYGROUND_API_PATH = /

PLAYGROUND_IAP_REQUIRED = false
```

The `PLAYGROUND_API_TOKEN` remains unchanged.