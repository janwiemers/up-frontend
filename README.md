<div align="center">
  <img height="100px" src="src/assets/logo.svg" />
</div>

# `up-frontend`

Provides a Web-Frontend for [`up`](https://github.com/janwiemers/up). It uses websockets to update the dashboard in realtime.

## Development

To run the project locally you need to have a instance of `up` running and

```
git clone git@github.com:janwiemers/up-frontend.git
npm install
npm run serve
```

### Compiles and minifies for production

```
npm run build
```

### Run your unit tests

```
npm run test:unit
```

### Lints and fixes files

```
npm run lint
```

### Customize configuration

See [Configuration Reference](https://cli.vuejs.org/config/).

## How to contribute

I'm really glad you're reading this.

Submitting changes

- Fork this repository
- Create a branch in your fork
- Send a Pull Request along wih a clear description of your changes as well as specs

Always write a clear log message for your commits. One-line messages are fine for small changes, but bigger changes should look like this:

```
$ git commit -m "A brief summary of the commit

> A paragraph describing what changed and its impact."
> Coding conventions
> Start reading our code and you'll get the hang of it. We optimize for readability:
```
