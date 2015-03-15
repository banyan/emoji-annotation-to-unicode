require 'json'
require 'open-uri'

open("https://api.github.com/emojis") {|f|
  json = JSON.pretty_generate JSON.parse(f.read).map { |line|
    line[1].match(/unicode\/(.+)\.png/)
    { line[0] => $1 }
  }

  File.binwrite("emoji-anotation-to-unicode.js", 'module.exports = ' + json)
}
