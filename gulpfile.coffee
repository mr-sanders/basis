gulp = require 'gulp'
connect = require 'gulp-connect'
# sass = require 'gulp-sass'
sass = require 'gulp-ruby-sass'
autoprefixer = require 'gulp-autoprefixer'
plumber = require 'gulp-plumber'

gulp.task 'connect', ->
	connect.server
		port: 1337
		livereload: on
		root: './dist'

gulp.task 'html', ->
	gulp.src 'dist/*.html'
		.pipe do connect.reload

gulp.task 'sass', ->
	sass 'sass', { 
		noCache: true,
		style: 'compressed'
	}
	.on 'error', (err) ->
		console.log err.message
	.pipe do autoprefixer
	.pipe gulp.dest 'dist/css'
	.pipe do connect.reload

gulp.task 'js', ->
	gulp.src 'js/*.js'
		.pipe gulp.dest 'dist/js'
		.pipe do connect.reload

gulp.task 'watch', ->
	gulp.watch 'dist/*.html', ['html']
	gulp.watch 'sass/*.scss', ['sass']
	gulp.watch 'js/*.js', ['js']

gulp.task	'default', ['html', 'sass', 'js', 'connect', 'watch']