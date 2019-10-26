This file will need to be explained a bit better. Basically the idea is to only
export things we need for package.json, but otherwise serve as the Cakefile

    module.exports =
      preinstall: './buildlib.sh'
      postinstall: 'ls'
      start: 'brunch watch --server'
      test: 'coffee src/test.coffee'

