# help_for_early_years_providers

This is a Rails 7.1 app.

## Prerequisites

This project requires:

- Ruby (see [.ruby-version](./.ruby-version)), preferably managed using [rbenv](https://github.com/rbenv/rbenv)
- Node 18 (LTS) or newer
- Yarn 1.x (classic)
- PostgreSQL must be installed and accepting connections

On macOS, these [Homebrew](http://brew.sh) packages are recommended:

```
brew install rbenv
brew install node
brew install yarn
brew install postgresql@16
```

## Getting started

### bin/setup

Run this script to install necessary dependencies and prepare the Rails app to be started for the first time.

```
bin/setup
```

> [!TIP]
> The `bin/setup` script is idempotent and is designed to be run often. You should run it every time you pull code that introduces new dependencies or makes other significant changes to the project.

### Run the app!

Start the Rails server with this command:

```
bin/rails s
```

The app will be located at <http://localhost:3000/>.

## Development

Use this command to run the full suite of automated tests and lint checks:

```
bin/rake
```

> [!TIP]
> Rake allows you to run all checks in parallel with the `-m` option. This is much faster, but since the output is interleaved, it may be harder to read.

```
bin/rake -m
```

### Fixing lint issues

Some lint issues can be auto-corrected. To fix them, run:

```
bin/rake fix
```

> [!WARNING]
> A small number of Rubocop's auto-corrections are considered "unsafe" and may
> occasionally produce incorrect results. After running `fix`, you should
> review the changes and make sure the code still works as intended.

## Setup

### Prerequisites

This project depends on:

  - [Ruby](https://www.ruby-lang.org/)
  - [Ruby on Rails](https://rubyonrails.org/)
  - [NodeJS](https://nodejs.org/)
  - [Yarn](https://yarnpkg.com/)
  - [Postgres](https://www.postgresql.org/)

### asdf

This project uses `asdf`. Use the following to install the required tools:

```sh
# The first time
brew install asdf # Mac-specific
asdf plugin add ruby
asdf plugin add nodejs
asdf plugin add yarn
asdf plugin add postgres

# To install (or update, following a change to .tool-versions)
asdf install
```

When installing the `pg` gem, bundle changes directory outside of this
project directory, causing it lose track of which version of postgres has
been selected in the project's `.tool-versions` file. To ensure the `pg` gem
installs correctly, you'll want to set the version of postgres that `asdf`
will use:

```sh
# Temporarily set the version of postgres to use to build the pg gem
ASDF_POSTGRES_VERSION=13.5 bundle install
```

### Intellisense

[solargraph](https://github.com/castwide/solargraph) is bundled as part of the
development dependencies. You need to [set it up for your
editor](https://github.com/castwide/solargraph#using-solargraph), and then run
this command to index your local bundle (re-run if/when we install new
dependencies and you want completion):

```sh
bin/bundle exec yard gems
```

You'll also need to configure your editor's `solargraph` plugin to
`useBundler`:

```diff
+  "solargraph.useBundler": true,
```
## How the application works

We keep track of architecture decisions in [Architecture Decision Records
(ADRs)](/adr/).

We use `rladr` to generate the boilerplate for new records:

```bash
bin/bundle exec rladr new title
```
