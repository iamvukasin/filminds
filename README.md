# Filminds

## Table of contents

  * [Getting started](#getting-started)
    * [Front-end](#front-end)
    * [Backend-end](#back-end)
  * [License](#license)

## Getting started

### Front-end

Before building and running the project, make sure you have installed [Node.js](https://nodejs.org/en/download/) and
[Yarn](https://yarnpkg.com/en/docs/install). Now, you have to install [Gulp](https://gulpjs.com/):

```bash
$ npm install gulp-cli -g
```

And then move to the project's root folder and install all dependencies:

```bash
$ yarn
```

If you want to build the project, just type:

```bash
$ gulp
```

### Back-end

We use Django as our back-end framework. Before running the project make sure you have installed
[Python 3](https://www.python.org/downloads/) and
[Pipenv](https://pipenv.readthedocs.io/en/latest/install/#installing-pipenv). To download the dependencies, just type:

```bash
$ pipenv install --dev
```

To run the project, make sure you're in the project's root and type:

```bash
$ python manage.py runserver
```

## License

Filminds is released under the [MIT license](LICENSE).
