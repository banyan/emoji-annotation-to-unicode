require 'json'
require 'open-uri'

open("https://api.github.com/emojis") { |f|
  h = Hash.new.tap { |row|
    JSON.parse(f.read).each { |line|
      line[1].match(/unicode\/(.+)\.png/)
      row[line[0]] = $1
    }
  }.merge({
    # custom annotation over github
    simple_smile: '1f642'
  })
  json = JSON.pretty_generate h
  File.binwrite("emoji-annotation-to-unicode.js", 'module.exports = ' + json)
}
