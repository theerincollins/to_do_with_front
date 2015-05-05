require('./lib/list')
require('./lib/task')
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('pry')
require('pg')

DB = PG.connect({:dbname => "to_do_test"})

get('/') do
  @lists = List.all()
  erb(:index)
end

get('/list/add') do
  erb(:add_list)
end

post('/save/list') do
  list_name = params.fetch('list_name')
  new_list = List.new({:name => list_name, :id => nil})
  new_list.save()
  @lists = List.all
  erb(:index)
end

get('/list/:id') do
  id = params.fetch("id").to_i
  @list = List.find(id)
  erb(:list)
end

post('/save/task') do
  description = params.fetch("task")
  list_id = params.fetch("list_id").to_i()
  @list = List.find(list_id)
  @task = Task.new({:description => description, :list_id => list_id})
  @task.save()
  erb(:list)
end
