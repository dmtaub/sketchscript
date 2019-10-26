# sketchscript: literate code for storytelling

This file, and all other .litcoffee files in this repo, flip the idea of coding
around. Instead of reading a code document with occasional comments, you are now
reading a comment document with occasional code. Sections set apart after a
blank line and indented by four or more spaces will run as code:

    console.log('Running README...')

    # However, anything after a hashtag is ignored, even if set off & indented.
    #
    # console.log("This won't appear when running README.litcoffee")

## SketchScript Bootstrapping

Lets assumes you already have node, npm, and coffeescript.
If you don't have `coffee` or `cake` commands, do `npm install -g coffeescript`.

Then `coffee README.litcoffee` or `cake bootstrap` will set up the node package!

After that, if you'd like to work on this projects itself, use `npm install` for

    devDependencies =
      brunch: '2.10.17'
      'coffee-script-brunch': '3.0.0'

### Our package definition

Node/npm uses a `pacakge.json` file, and we be creating ours here.
We will also talk you through some basic coffeescript concepts.

The sequence `(->` begins a closure, or nameless function, for us to run later:

    (->
      exports.package =
        name: 'sketchscript'
        version: '1.0.0'
        description: 'literate programming playground'
        main: 'README.litcoffee'
        author: 'mdan'
        license: 'AGPL-3.0'
        scripts: arguments[0]   # first element of the special 'arguments' list
        devDependencies: devDependencies   # this was defined on line 12, above

Note that the scripts are defined in a separate file, `tools/scripts`.

### A note on modules and functions

The word 'exports' above lets us treat this file as a _module_ that can be used
to get the data and code here in another document.

Now, from another file, we can do ` readme = require './README.litcoffee' ` to
get a `readme` object with a `package` property, accessible as `readme.package`.

Until we run this closure, `exports.package` will not exist.  We can run the
nameless function with parentheses() to call it. We can also name functions and
run them that way: `run = -> ...what to do...`, then `do run` or `run(args)`.

### Finishing the export definition

We will end our closure with a second parenthesis `)` then run it with `()`.
Since we referenced the script section before as `arguments[0]` we need the
scripts to be _passed in_ as the first argument to the function _call_.

    )( require('./tools/scripts.litcoffee') )

In this case, we get the scripts from another file, using `require`.

Now that we have all the data, we use node's built-in JSON object to string-ify.

    formattedJSON = JSON.stringify(exports.package, null, '  ')

The `null` indicates that we want to take all properties, rather than just some.

### Writing package.json

In order for us to use our package.json, we first must save a file to disk using
node's core `fs` library:

    fs = require('fs')
    fs.writeFileSync('package.json', formattedJSON)

    console.log('ready to use npm commands!')


## Build System

We're using coffeescript's built-in cake task runner.
Running another closure, with coffeescrips 'do' this time

do ->
  await fs.writefile
  clean: 'rm -rf node_modules && rm package.json'
