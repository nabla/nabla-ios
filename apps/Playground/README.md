# Playground

## Getting started

Make your own `User.xcconfig`:

```sh
cp Playground/Configs/User.xcconfig.template Playground/Configs/User.xcconfig
```

Then replace `<nickname>` where needed (your email address is `<nickname>@nabla.com`).

If working on the simulator only, you can also use `localhost` with port `8080` and disable the IAP.

To generate the `PLAYGROUND_API_TOKEN`, log in as an admin on the platform. Go to `Settings` > `API Keys` and generate a new one. Copy the token after `Authorization: Bearer ` and paste it in your `User.xcconfig` file.