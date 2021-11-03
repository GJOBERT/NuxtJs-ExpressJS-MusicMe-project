# Projet MusicMe

Projet de fin de formation Coding Academy. Réalisation d'une application web pour la vente en ligne de vinyles.

## Technologies

* MariaDB
* NodeJS (with Express)
* VueJS (with Nuxt and Vuetify)

## **Installation**


### Etape 1 : Cloner le dépôt

```bash
git clone git@github.com:EpitechIT2020/C-COD-260-BDX-2-1-ecp-christopher.efoua.git
```

### Etape 2 : Initier la base de données

```bash
cd 1_Database/
pwd 
```
Copier le chemin

```bash
mysql -u user -p 
```

```mysql
source music_me.sql
```

__Dans le dossier 2_API/__

Modifier le fichier .env

```
DB_HOST=localhost
DB_USER=your db username
DB_PASS=your db password
DB_NAME=music_me
PORT=3333
SECRET_TOKEN=your secret token
```


### Etape 3 : Installer les dépendances

__A la racine du projet__

```bash
npm install
npm install --global nodemon
```

### Etape 4 : Lancer les serveurs

__Dans le dossier 2_API/__


```bash
npm install
nodemon start
```

__Dans le dossier 3_front/__

```bash
npm install
npm run dev
```

### Etape 5 : Accéder à l'application web

Rendez vous à l'adresse : [localhost:3000](http://localhost:3000)

