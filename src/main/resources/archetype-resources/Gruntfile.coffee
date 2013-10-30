destName = "myapp"
buildDir = "target/grunt"
coffeeSrcDir = "src/main/coffee"
coffeeTestSrcDir = "src/test/coffee"


bla = ->
  x = buildDir+"/dist/"+destName+".min.js"
  y = {}
  y[x] = ["#{buildDir}/dist/#{destName}.js"]
  y

module.exports = (grunt) ->

  grunt.initConfig

    pkg: grunt.file.readJSON "package.json"

    pom: parsePom grunt.file.read "pom.xml"

    # Copy needed dependencies to lib folder
    bower:
      install:
        options:
          targetDir: "#{buildDir}/lib"

    # Transcompile CoffeeScript to JavaScript files
    coffee:
      compile:
        options:
          bare: true
        expand: true
        src: ["#{coffeeSrcDir}/**/*.coffee", "#{coffeeTestSrcDir}/**/*.coffee", "Gruntfile.coffee"]
        dest: "#{buildDir}/js"
        ext: ".js"

    # Join JavaScript files   
    browserify:
      main:
        src: ["#{buildDir}/js/#{coffeeSrcDir}/main.js"]
        dest: "#{buildDir}/dist/#{destName}.js"
        options:
          standalone: destName
      test:
        src: ["#{buildDir}/js/#{coffeeTestSrcDir}/**/*Spec.js"]
        dest: "#{buildDir}/test/#{destName}-test.js"
        options:
          aliasMappings: [
            cwd: "#{buildDir}/js/#{coffeeSrcDir}"
            src: ["**/*.js"]
          ]

    # Run unit tests
    jasmine:
      runTests:
        options:
          specs: "#{buildDir}/test/#{destName}-test.js"
          vendor: [ # add external libraries which are needed in tests
            "#{buildDir}/lib/**/*.js"
          ]
          keepRunner: true
          outfile: "#{buildDir}/test/SpecRunner.html"

    # Minify main JavaScript file
    uglify:
      minifyMain:
        files: bla()

  #grunt.loadNpmTasks "grunt-contrib-watch"
  #grunt.loadNpmTasks "grunt-contrib-clean"
  #grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-bower-task"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-browserify"
  grunt.loadNpmTasks "grunt-contrib-jasmine"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  
  

  #grunt.registerTask "dev", ["clean", "coffee", "copy:jsSrc", "browserify", "jasmine", "copy:dist2app"]
  #grunt.registerTask "default", ["clean", "coffee", "copy:jsSrc", "browserify", "jasmine", "uglify"]

  grunt.registerTask "default", ["bower", "coffee", "browserify", "jasmine", "uglify"]


# Extract some data from a POM file.
parsePom = (pom) ->
  # Helper to extract content from first matching tag with given name.
  tagContent = (name) -> ((new RegExp "<#{name}>(.*)<\/#{name}>").exec pom)[1]
  # Extract some content from POM.
  groupId:    tagContent "groupId"
  artifactId: tagContent "artifactId"
  version:    tagContent "version"