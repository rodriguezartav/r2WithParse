require('jqueryify')
require('rspine')
require('lib/parseAjax')
require('lib/parseModel')


Date.prototype.toGMT = ->
  hours = this.getUTCHours()
  hours = "0" + hours if hours < 10
 
  minutes = this.getUTCMinutes()
  minutes = "0" + minutes if minutes < 10
 
  months = this.getUTCMonth() + 1
  months = "0" + months if months < 10
 
  date = this.getUTCDate()
  date = "0" + date if date < 10
 
  str = ""
  str += this.getUTCFullYear()
  str += "-"
  str += months
  str += "-"
  str += date
  str += "T"
  str += hours
  str += ":"
  str += minutes
  str += ":"
  str += "00Z"
  return str
  
