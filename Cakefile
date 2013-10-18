# =======================================================================================
# Dependencies and constants
# =======================================================================================
logPrefix = "[Cake]:"

child_process = require('child_process')
sys = require('sys')

print = sys.print
exec = child_process.exec
spawn = child_process.spawn


# =======================================================================================
# Utility functions
# =======================================================================================
log = (data)->
  print(data.toString())

warn = (data)->
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
        console.warn("[#{(new Date()).toUTCString()}] #{logPrefix} Failed to fetch latest version for #{lib} with an error: #{error}")
    )

  _checkVersion(lib, version) for lib, version of list

npmInstall = (callb)->
  console.log("[#{(new Date()).toUTCString()}] #{logPrefix} Updating dependency tree")

  exec('npm install', (error, stdout, stderr) ->
    unless error
      callb?()
    else
      console.warn("[#{(new Date()).toUTCString()}] #{logPrefix} Dependencies installation failed with an error: #{error}")
  )

bowerInstall = (callb)->
  console.log("[#{(new Date()).toUTCString()}] #{logPrefix} Updating bower")

  exec('bower install', (error, stdout, stderr) ->
    unless error
      callb?()
    else
      console.warn("[#{(new Date()).toUTCString()}] #{logPrefix} Bower dependencies installation failed with an error: #{error}")
  )

startGrunt = ->
  console.log("[#{(new Date()).toUTCString()}] #{logPrefix} Executing grunt")

  hog = exec('grunt')
  hog.stdout.on('data', log)
  hog.stderr.on('data', warn)

buildGrunt = (callb)->
  console.log("[#{(new Date()).toUTCString()}] #{logPrefix} Executing grunt build")

  exec('grunt build', (error, stdout, stderr) ->
    unless error
      callb?()
    else
      console.warn("[#{(new Date()).toUTCString()}] #{logPrefix} Grunt build failed with an error: #{error}")
  )


# =======================================================================================
# Tasks
# =======================================================================================
task 'versions', '[DEV]: Check package.json versions state', ->
  list = ['dependencies', 'devDependencies', 'peerDependencies']
  checkVersions(require('./package')[item]) for item in list

task 'dev', '[DEV]: Devserver with autoreload', ->
  npmInstall ->
    bowerInstall startGrunt
