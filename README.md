# Diagnostic

https://diagnostic.noesya.coop

## Setup

```
bundle
yarn
rails db:create db:migrate
```

Vérifier que les binaires venant des `node_modules` sont utilisés par votre PATH avec les commandes `lighthouse --version` et/ou `which lighthouse`.

Si ce n'est pas le cas, ajoutez ceci dans votre fichier de configuration shell (ex: `~/.zshrc`) :
```
export PATH=./node_modules/.bin:$PATH
```

## Run

```
rails s
rails jobs:work
```

## Deploy

Déploiement automatique quand on push sur GitHub.
