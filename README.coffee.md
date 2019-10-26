# sketchscript: literate code for storytelling

## SketchScript Bootstrapping

SketchScript assumes you have node, npm, and coffeescript. Coffeescript will
provide both `cake` and `coffee`. Install with `npm install -g coffeescript`.

Now, `coffee README.coffee.md` or `cake bootstrap` will set up the node package!

If you'd like to develop, too, `npm install` will download the following

    devDependencies =
      brunch: '2.10.17'
      'coffee-script-brunch': '3.0.0'

### Our package definition

Node/npm uses a `pacakge.json` file, and we be creating ours here.
We will also talk you through some basic coffeescript and literate coffeescript.

In literate coffeescript, code blocks in markdown files like this one will run
if they start with 4 or more spaces:

    # However, anything after a hashtag is ignored, even if indented.
    # This next sequence of symbols starts a closure that we will run later:

    (->
      exports.package =
        name: 'sketchscript'
        version: '1.0.0'
        description: 'literate programming playground'
        main: 'README.coffee.md'
        author: 'mdan'
        license: 'AGPL'
        scripts: arguments[0]   # first element of the special 'arguments' list
        devDependencies: devDependencies   # this was defined on line 12, above

### A note on modules and functions

The word 'exports' above lets us treat this file as a _module_ that can be used
to get the data and code here in another file.

Now, from another file, we can do ` readme = require './README.coffee.md' ` to
get a `readme` object with a `package` property, accessible as `readme.package`.

Until we run the closure, the export will not actually be defined.  We run the
nameless function with parentheses() to call it. We could also have named the
function and run it that way: `fun = -> ...` then `fun(args)` or `do fun args`.

### Finishing the export definition

Require the scripts, pass them in to the closure, and run it with parentheses().

    )( require('./tools/scripts.coffee.md') )


### Writing package.json

In order to write this file, we need to require node's `fs` modules.

    fs = require('fs')
    formattedJSON = JSON.stringify(exports.package, null, '  ')
    fs.writeFileSync('package.json', formattedJSON)


## Build System

We're using coffeescript's built-in cake task runner.
Running another closure, with coffeescrips 'do' this time

do ->
  await fs.writefile
  clean: 'rm -rf node_modules && rm package.json'
