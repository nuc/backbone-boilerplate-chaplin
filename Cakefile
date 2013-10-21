# =======================================================================================
# Dependencies and constants
# =======================================================================================
logPrefix = "[Cake]:"

{spawn, exec} = require 'child_process'
{print} = require 'sys'


# =======================================================================================
# Utility functions
# =======================================================================================
log = (message) ->
  console.log("[#{(new Date()).toUTCString()}] #{logPrefix} #{message}")

proxyLog = (data)->
  print(data.toString())

proxyWarn = (data)->
  process.stderr.write(data.toString())

checkVersions = (list)->
  sty = require('sty')

  _checkVersion = (lib, version)->
    exec("npm info #{lib} version", (error, stdout, stderr) ->
      unless error
        latest = stdout.replace('\n\n', '')
        current = version.replace(/[\<\>\=\~]*/, '')

        if current is latest
          console.log("#{sty.bold sty.green 'OK:'} #{lib} #{current}")
        else
          if current is '*'
            console.warn("#{sty.bold sty.cyan 'NOTICE:'} #{lib} version number not specified: #{current}, latest: #{latest}")
          else
            console.warn("#{sty.bold sty.red 'WARN:'} #{lib} needs to be updated, current: #{current}, latest: #{latest}")
      else
        log("Failed to fetch latest version for #{lib} with an error: #{error}")
    )

  _checkVersion(lib, version) for lib, version of list

npmInstall = (callb)->
  log('Updating dependency tree')

  exec('npm install', (error, stdout, stderr) ->
    unless error
      callb?()
    else
      log("Dependencies installation failed with an error: #{error}")
  )

bowerInstall = (callb)->
  log('Updating bower')

  exec('bower install', (error, stdout, stderr) ->
    unless error
      callb?()
    else
      log("Bower dependencies installation failed with an error: #{error}")
  )

startGrunt = ->
  log('Executing grunt')

  hog = exec('grunt')
  hog.stdout.on('data', proxyLog)
  hog.stderr.on('data', proxyWarn)

buildGrunt = (callb)->
  log('Executing grunt build')

  exec('grunt build', (error, stdout, stderr) ->
    unless error
      callb?()
    else
      log("Grunt build failed with an error: #{error}")
  )


# =======================================================================================
# Tasks
# =======================================================================================
task 'versions', '[DEV]: Check package.json versions state', ->
  list = ['dependencies', 'devDependencies', 'peerDependencies']
  checkVersions(require('./package')[item]) for item in list

task 'dev', '[DEV]: Devserver with autoreload', ->
  npmInstall bowerInstall startGrunt
