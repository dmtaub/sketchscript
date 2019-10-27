# SketchScript: Literate Code for Storytelling

This file, and all other .litcoffee files in this repo, flip the idea of coding
around. Instead of seeing a code file with readable comments for documentation,
you are now reading an English document with runnable code blocks. Sections set
apart after a blank line and indented by four or more spaces will be executed:

    print = console.log                  # alias the output function for clarity
    print 'Running README...'

However, anything after a hashtag is ignored, even if set apart and indented.

    # print "This won't appear when running README.litcoffee"

## SketchScript Bootstrapping

You will need [node, npm](https://nodejs.org/en/download/), and coffeescript.
Once you have node, do `npm install -g coffeescript` to get `coffee` and `cake`.
Then, `coffee README.litcoffee` or `cake bake` will set up the node package!

To use the development server, you can run `npm install` now. This will download

    devDependencies =
      brunch: '2.10.17'
      'coffee-script-brunch': '3.0.0'

that can be used to host a local web server.

### Our package definition

Node/npm requires a `package.json` file, and we create and save ours right here!

Lets create a function called `runme`.

Everything indented after the arrow `->` will be part of this new function that
we are assigning to a _variable_ called `runme`:

    runme = ->
      exports.package =
        name: 'sketchscript'
        version: '1.0.0'
        description: 'literate programming playground'
        main: 'README.litcoffee'
        author: 'mdan'
        license: 'AGPL-3.0'
        scripts: arguments[0]              # this will be passed in when run
        devDependencies: devDependencies   # this was defined on line 12, above

    # de-indenting here says we're done writing the 'runme' function

### A note on modules and functions

The word 'exports' above lets us treat this file as a _module_ that can be used
to get the data and code that is in this file from another document.

We have alreday done this in another file (`scripts.litcoffee` in the `tools`
directory) so that we can assign a variable here to reference the data there:

    scripts = require './tools/scripts.litcoffee'

Now, `scripts` contains the information that is in the `scripts.litcoffee` file.

### Calling the function

Until we _execute_ `runme()`, `exports.package` **does not exist**.

Let's execute it now, making sure to send, or _pass in_, our `scripts` varible
as the first _argument_ to the function _call_.

    runme scripts

#### NOTES
* It would also work with _explicit parentheses_, as `runme(scripts)`. This is
often helpful for spreading a function call over multiple lines of code.
* Inside the function, the special `arguments` array will have the data from
`scripts` in _array index 0_. We can access this data with square brackets:
`arguments[0]`.
* We wouldn't have to use the `arguments` array if we defined the function with
a name to call this argument, for example, with `runme = (scriptSection) ->`

### Formatting data as a text string

Now that we have all the data stored in `exports.package`, let's make it into a
_string_ of characters using the build-in `JSON` object's `stringify` method:

    print '...serializing to pretty-printed json...'

    formattedJSON = JSON.stringify(exports.package, null, '  ')

The second argument is `null` to indicate that we want to include all
properties, rather than just some, in our output text.

### Writing package.json

In order for us to use our package.json, we must save this file using node's
core `fs` library:

    print '...writing to disk...'

    fs = require('fs')
    fs.writeFileSync('package.json', formattedJSON)

    print '...ready to use npm commands!'

If you haven't already, now may be a good time to run this file with `cake bake`
