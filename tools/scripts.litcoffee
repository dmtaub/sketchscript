This file will need to be explained a bit better. Basically the idea is to only
export things we need for package.json, but have it runnable for cake scripts

    module.exports =

The preinstall script ensures we recreate package.json before `npm install`ing.

      preinstall: 'coffee README.litcoffee'            # please don't change me!
      postinstall: 'echo Done with \'npm install\''

These lines are only used for development of this project itself:

      start: 'brunch watch --server'
      test: 'coffee tools/test.litcoffee'
      clean: 'rm -rf node_modules && rm package.json'
