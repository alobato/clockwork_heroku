require 'clockwork'
require 'net/http'
require 'open-uri'
include Clockwork

handler do |job|

  if job == 'resposta'
    resposta = URI.parse('http://al-123board.herokuapp.com/metrics/5.txt').read
    if resposta.to_i > 500
      Net::HTTP.post_form(URI.parse('http://api.prowlapp.com/publicapi/add'), { apikey: '9e6b86dec361a6c01080d481ba18974a2e38f4e4', application: 'lb', event: 'Resposta', description: resposta, priority: 0 }) rescue nil
    end
  end

  if job == 'online'
    online = URI.parse('http://al-123board.herokuapp.com/metrics/4.txt').read
    if online.to_i > 60
      Net::HTTP.post_form(URI.parse('http://api.prowlapp.com/publicapi/add'), { apikey: '9e6b86dec361a6c01080d481ba18974a2e38f4e4', application: 'lb', event: 'Online', description: online, priority: 0 }) rescue nil
    end
  end

  if job == 'ruby_ram'
    ruby_ram = URI.parse('http://al-123board.herokuapp.com/metrics/6.txt').read.gsub("\n", '')
    if ruby_ram.to_f > 120
      Net::HTTP.post_form(URI.parse('http://api.prowlapp.com/publicapi/add'), { apikey: '9e6b86dec361a6c01080d481ba18974a2e38f4e4', application: 'lb', event: 'Ruby RAM', description: ruby_ram, priority: 0 }) rescue nil
    end
  end

end

every(2.minutes, 'resposta')
every(5.minutes, 'online')
every(2.minute, 'ruby_ram')
