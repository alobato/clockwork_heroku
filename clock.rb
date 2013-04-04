# https://gist.github.com/tomykaira/1312172
require 'clockwork'
include Clockwork

handler do |job|
  puts job
end

every(1.day, 'job')
