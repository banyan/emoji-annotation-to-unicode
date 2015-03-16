require 'json'
require 'open-uri'

open("https://api.github.com/emojis") {|f|
  h = {}
  JSON.parse(f.read).each { |line|
    line[1].match(/unicode\/(.+)\.png/)
    h[line[0]] = $1
  }
  json = JSON.pretty_generate h
  File.binwrite("emoji-annotation-to-unicode.js", 'module.exports = ' + json)
}
