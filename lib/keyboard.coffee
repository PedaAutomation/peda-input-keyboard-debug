readline = require 'readline'

fixStdoutFor = (cli) ->
  oldStdout = process.stdout
  newStdout = Object.create oldStdout
  newStdout.write = ->
      cli.output.write '\x1b[2K\r'
      result = oldStdout.write.apply(
          this,
          Array.prototype.slice.call(arguments)
      )
      cli._refreshLine()
      result

  process.__defineGetter__ 'stdout', -> 
    newStdout

fixStdoutFor readline

readKeyboard = (cbout, cbin) -> 
  rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  })

  rl.question "Use following Syntax: \"logic: capability|message\" or \"input: message\"", (answer) ->
    answer = answer.split(":")
   
    if answer.length < 2
      console.log "wrong input"      
    
    else
      switch answer[0]
       
        when "output"
          temp = answer[1].split("|")
          if temp.length > 1
            cbout temp[1], temp[0]
       
        when "input"
          cbin answer[1]
    
    rl.close()
    readKeyboard

module.exports.readKeyboard = readKeyboard

