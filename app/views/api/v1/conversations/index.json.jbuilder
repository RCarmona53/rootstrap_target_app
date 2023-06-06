json.conversations @conversations do |conversation|
  json.partial! 'conversation', conversation:
end
