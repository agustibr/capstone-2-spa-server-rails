# json.extract! state, :id, :name, :created_at, :updated_at

json.id state.id.to_s
json.name state.name
json.created_at state.created_at
json.updated_at state.updated_at
json.url state_url(state, format: :json)