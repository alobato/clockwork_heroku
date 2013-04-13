require 'clockwork'
require 'net/http'
require 'open-uri'
include Clockwork

handler do |job|

  if job == 'resposta'
    resposta = URI.parse('http://al-123board.herokuapp.com/metrics/5.txt').read
    if resposta.to_i > 900
      Net::HTTP.post_form(URI.parse('http://api.prowlapp.com/publicapi/add'), { apikey: '9e6b86dec361a6c01080d481ba18974a2e38f4e4', application: 'lb', event: 'Resposta', description: resposta, priority: 0 }) rescue nil
    end
  end

  if job == 'online'
    online = URI.parse('http://al-123board.herokuapp.com/metrics/4.txt').read
    if online.to_i > 100
      Net::HTTP.post_form(URI.parse('http://api.prowlapp.com/publicapi/add'), { apikey: '9e6b86dec361a6c01080d481ba18974a2e38f4e4', application: 'lb', event: 'Online', description: online, priority: 0 }) rescue nil
    end
  end

  if job == 'ruby_memory'
    ruby_memory = URI.parse('http://al-123board.herokuapp.com/metrics/6.txt').read.gsub("\n", '')
    if ruby_memory.to_f > 140
      Net::HTTP.post_form(URI.parse('http://api.prowlapp.com/publicapi/add'), { apikey: '9e6b86dec361a6c01080d481ba18974a2e38f4e4', application: 'lb', event: 'ruby_memory', description: ruby_memory, priority: 0 }) rescue nil
    end
  end

  if job == 'mysql_memory'
    mysql_memory = URI.parse('http://al-123board.herokuapp.com/metrics/7.txt').read.gsub("\n", '')
    if mysql_memory.to_f > 20.5
      Net::HTTP.post_form(URI.parse('http://api.prowlapp.com/publicapi/add'), { apikey: '9e6b86dec361a6c01080d481ba18974a2e38f4e4', application: 'lb', event: 'mysql_memory', description: mysql_memory, priority: 0 }) rescue nil
    end
  end

  if job == 'nginx_memory'
    nginx_memory = URI.parse('http://al-123board.herokuapp.com/metrics/8.txt').read.gsub("\n", '')
    if nginx_memory.to_f > 3.7
      Net::HTTP.post_form(URI.parse('http://api.prowlapp.com/publicapi/add'), { apikey: '9e6b86dec361a6c01080d481ba18974a2e38f4e4', application: 'lb', event: 'nginx_memory', description: nginx_memory, priority: 0 }) rescue nil
    end
  end

end

every(2.minutes, 'resposta')
every(5.minutes, 'online')
every(2.minutes, 'ruby_memory')
every(5.minutes, 'mysql_memory')
every(5.minutes, 'nginx_memory')
