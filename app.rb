require('./lib/list')
require('./lib/task')
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('pry')
require('pg')

DB = PG.connect({:dbname => "to_do"})

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
  erb(:success)
end

get('/list/:id') do
  @id = params.fetch("id").to_i
  @list_to_show = List.find(@id)
  @tasks = @list_to_show.get_tasks()
  erb(:list)
end

post('/save/task') do
#  new_list_id = params.fetch('list_id').to_i()
  @list_to_show = List.find(@id)
  new_description1 = params.fetch('task1')
  new_description2 = params.fetch('task2')
  new_description3 = params.fetch('task3')
  new_description4 = params.fetch('task4')
  list_id = @id
  new_task1 = Task.new({:description => new_description1, :list_id => list_id})
  new_task1.save()
  new_task2 = Task.new({:description => new_description2, :list_id => list_id})
  new_task2.save()
  new_task3 = Task.new({:description => new_description3, :list_id => list_id})
  new_task3.save()
  new_task4 = Task.new({:description => new_description4, :list_id => list_id})
  new_task4.save()
  erb(:success)
end
