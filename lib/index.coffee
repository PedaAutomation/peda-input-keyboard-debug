keyboard = require './keyboard.coffee'
helper = null

sendInput = (data) ->
  helper.sendInput data
sendOutput = (data, target) ->
   helper.sendOutputToCapability data, target
   
module.exports = (slave) ->
  helper = slave  
  slave.setType "input" 

  keyboard.readKeyboard sendOutput, sendInput
  