require 'clockwork'
require 'net/http'
require 'open-uri'
include Clockwork

handler do |job|
  resposta = URI.parse('http://al-123board.herokuapp.com/metrics/5.txt').read
  if resposta.to_i > 300
    Net::HTTP.post_form(URI.parse('http://api.prowlapp.com/publicapi/add'), { apikey: '9e6b86dec361a6c01080d481ba18974a2e38f4e4', application: 'lb', event: 'Resposta', description: resposta, priority: 0 }) rescue nil
  end
end

every(5.minutes, 'job')
