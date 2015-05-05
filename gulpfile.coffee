gulp        = require 'gulp'
browserify  = require 'browserify'
source      = require 'vinyl-source-stream'
browserSync = require 'browser-sync'

gulp.path =
  app: 'app'
  dist: 'dist'

gulp.task 'build', ->
  gulp.src "#{@path.app}/index.html"
    .pipe gulp.dest("#{@path.dist}/")

  browserify
      entries: ["./#{@path.app}/app.coffee"]
      extensions: ['.coffee', '.js']
    .transform 'coffeeify'
    .bundle()
    .pipe source 'app.js'
    .pipe gulp.dest("#{@path.dist}/")

gulp.task 'serve', ['build'], ->
  browserSync
    server:
      baseDir: "./#{@path.dist}/"
      index: 'index.html'
  gulp.watch("#{@path.app}/**/*", ['build'])
  gulp.watch("#{@path.dist}/**/*", browserSync.reload)
