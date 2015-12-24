json.array! @todos do |todo|
  json.(todo, :id, :content, :status)
end
