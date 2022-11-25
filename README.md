# Diagnostic

https://diagnostic.noesya.coop

## Setup

```
bundle
yarn
npm install lighthouse -g
rails db:create db:migrate
```

## Run

```
rails s
rails jobs:work
```

## Deploy

### Setup

```
git remote add scalingo git@ssh.osc-fr1.scalingo.com:coop-noesya-diagnostic.git
```

### Run

```
git push scalingo master
```
