Maven Grunt Archetype
=====================

Include JavaScript/CoffeeScript projects in a Maven based infrastructure.

Can e.g. be used if client side logic is needed in a war project.

Features
--------

* Creates a Maven jar artifact
* Maven style directory layout
* Module system (Common JS; with browserify)
* Dependency management (with bower)
* Unit Tests (with jasmine)
* Continuous testing (with grunt watch)
* CoffeeScript (optional)
* Code minification (with Uglify)
* Annotated Source Code (with Docco)

* CSS tools?


System Requirements
-------------------

* Grunt.js (needs node.js)
* Maven 3 (needs Java)


Build Steps
-----------

* Maven:
    * Get dependencies needed by Grunt to build project
    * Start Grunt

* Grunt:
    * Get project dependencies
    * Transcompile CoffeeScript to JavaScript
    * Run unit tests
    * Combine JavaScript Files
    * Minify JavaScript

* Maven
    * Create Jar File


Dependency management
---------------------

Install Bower:

    sudo npm install -g bower

Create Dependency file

    bower init

Search for needed dependencies:

    bower search [<name>]