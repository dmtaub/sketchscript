# SketchScript: Literate Code for Storytelling

This file, and all other .litcoffee files in this repo, flip the idea of coding
around. Instead of reading a code file with readable comments for documentation,
you are now reading an English document with runnable code blocks. Sections set
apart after a blank line and indented by four or more spaces will be executed:

    print = console.log                  # alias the output function for clarity
    print 'Running README...'

However, anything after a hashtag is ignored, even if set off & indented.

    # print "This won't appear when running README.litcoffee

## SketchScript Bootstrapping

Let's assumes you already have node, npm, and coffeescript.
If you don't have `coffee` or `cake` commands, do `npm install -g coffeescript`.

Then `coffee README.litcoffee` or `cake bake` will set up the node package!

After that, if you'd like to work on this project itself, use `npm install` for

    devDependencies =
      brunch: '2.10.17'
      'coffee-script-brunch': '3.0.0'

which will be used to run a local web server.

### Our package definition

Node/npm requires a `package.json` file, and we create and save ours right here!

Lets create a function called `runme`. Everything indented after the arrow `->`
is part of this function:

    runme = ->
      exports.package =
        name: 'sketchscript'
        version: '1.0.0'
        description: 'literate programming playground'
        main: 'README.litcoffee'
        author: 'mdan'
        license: 'AGPL-3.0'
        scripts: arguments[0]   # first element of the special 'arguments' list
        devDependencies: devDependencies   # this was defined on line 12, above

    # de-indenting here says we're done writing the 'runme' function

### A note on modules and functions

The word 'exports' above lets us treat this file as a _module_ that can be used
to get the data and code here in another document.

From another file, we can do ` readme = require './README.litcoffee' ` to create
a `readme` object with a `package` property, accessible as `readme.package`.

Let's do something similar right now to pull in scripts for our package.json:

    scripts = require('./tools/scripts.litcoffee')

### Calling the function

Until we _execute_ `runme()`, `exports.package` does not exist.  We can do this
now, with or without parentheses, making sure to _pass in_ the scripts as the
first _argument_ to this function _call_:

    runme(scripts)

NOTE: We could also have used _implicit parentheses_. e.g. `runme scripts`

### Formatting data as a text string

Now that we have all the data stored in `exports.package`, let's make it into a
_string_ of characters using the build-in `JSON` object's `stringify` method:

    print 'serializing package information to pretty-printed json...'

    formattedJSON = JSON.stringify(exports.package, null, '  ')

The second argument is `null` to indicate that we want to include all
properties, rather than just some, in our output text.

### Writing package.json

In order for us to use our package.json, we first must save this file using
node's core `fs` library:

    print 'writing to disk...'

    fs = require('fs')
    fs.writeFileSync('package.json', formattedJSON)

    print '...ready to use npm commands!'

If you haven't already, now may be a good time to run this file with `cake bake`
