# Purescript Concur Starter

A Starter kit for Purescript-Concur. Uses Npm, Spago, Google Closure Compiler, and Parcel. Builds tiny 180KB uncompressed bundles!

## Usage

### Grab the code

> git clone https://github.com/purescript-concur/purescript-concur-starter.git

Don't forget to tweak the project name and other details in package.json and bower.json

### Build code

> npm install

> npm run build

### Run Dev Server

> npm start

## Hot code reload with purescript code

At the end of the previous command, you will have a development server
which will watch for changes, and automatically reload the web page.
This mechanism only works with JS changes.

However, in practice, your IDE should automatically recompile Purescript to
Javascript on every change, which will be picked up by the development server.
So you get immediate recompilation even with Purescript.

### Build production artifacts

> npm run prod

The artifacts are put into the `dist/` folder.

## Sample Application

The starter kit contains a simple yet non-trivial concur application that lets you convert between feet and inches. It also acts as a mini tutorial for Concur. Read through the code at [Main.purs](src/Main.purs)!

The running application looks something like this -

<img width="409" alt="image" src="https://user-images.githubusercontent.com/127294/216365396-7f3338ea-f5b0-439b-a584-5f872523d873.png">
