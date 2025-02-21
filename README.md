# Filminds

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/35d44710dc094c6593f91597bebab237)](https://app.codacy.com/app/iamvukasin/filminds?utm_source=github.com&utm_medium=referral&utm_content=iamvukasin/filminds&utm_campaign=Badge_Grade_Dashboard)

## Table of contents

* [Getting started](#getting-started)
    * [Front-end](#front-end)
    * [Backend-end](#back-end)
    * [Configuration](#configuration)
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

### Configuration

All project configuration is controlled in the `config.py` file. Make sure you have added API keys here or via
environment variables:

```python
TMDB_API_KEY = <<TMDB_API_KEY>>
WIT_ACCESS_TOKEN = <<WIT_ACCESS_TOKEN>>
```

## License

Filminds is released under the [MIT license](LICENSE).
