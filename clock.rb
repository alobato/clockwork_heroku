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

    t = Time.now
    early = Time.new(t.year, t.month, t.day, 8, 0, 0, t.utc_offset)
    late  = Time.new(t.year, t.month, t.day, 23, 59, 0, t.utc_offset)
    if online == 0 && t.between?(early, late)
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
    if mysql_memory.to_f > 23
      Net::HTTP.post_form(URI.parse('http://api.prowlapp.com/publicapi/add'), { apikey: '9e6b86dec361a6c01080d481ba18974a2e38f4e4', application: 'lb', event: 'mysql_memory', description: mysql_memory, priority: 0 }) rescue nil
    end
  end

  if job == 'nginx_memory'
    nginx_memory = URI.parse('http://al-123board.herokuapp.com/metrics/8.txt').read.gsub("\n", '')
    if nginx_memory.to_f > 4
      Net::HTTP.post_form(URI.parse('http://api.prowlapp.com/publicapi/add'), { apikey: '9e6b86dec361a6c01080d481ba18974a2e38f4e4', application: 'lb', event: 'nginx_memory', description: nginx_memory, priority: 0 }) rescue nil
    end
  end

  if job == 'memory'
    memory = URI.parse('http://al-123board.herokuapp.com/metrics/13.txt').read.gsub("\n", '')
    if memory.to_f > 50
      Net::HTTP.post_form(URI.parse('http://api.prowlapp.com/publicapi/add'), { apikey: '9e6b86dec361a6c01080d481ba18974a2e38f4e4', application: 'lb', event: 'memory', description: memory, priority: 0 }) rescue nil
    end
  end

  if job == 'uptime'
    uptime = URI.parse('http://al-123board.herokuapp.com/metrics/15.txt').read.gsub("\n", '')
    unless uptime.include? 'days'
      Net::HTTP.post_form(URI.parse('http://api.prowlapp.com/publicapi/add'), { apikey: '9e6b86dec361a6c01080d481ba18974a2e38f4e4', application: 'lb', event: 'uptime', description: uptime, priority: 0 }) rescue nil
    end
  end

  if job == 'dafiti'
    dafiti = URI.parse('http://al-123board.herokuapp.com/metrics/11.txt').read.gsub("\n", '').gsub("R$ ", '')
    t = Time.now
    if (Time.new(t.year, t.month, t.day, 15, 0, 0, t.utc_offset) < t) && dafiti.to_f == 0
      Net::HTTP.post_form(URI.parse('http://api.prowlapp.com/publicapi/add'), { apikey: '9e6b86dec361a6c01080d481ba18974a2e38f4e4', application: 'lb', event: 'dafiti', description: dafiti, priority: 0 }) rescue nil
    end
  end

end

every(10.minutes, 'resposta')
every(10.minutes, 'online')
every(10.minutes, 'ruby_memory')
every(10.minutes, 'mysql_memory')
every(10.minutes, 'nginx_memory')
every(10.minutes, 'memory')
every(10.minutes, 'uptime')
every(60.minutes, 'dafiti')
