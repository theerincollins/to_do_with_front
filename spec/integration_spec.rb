require('capybara/rspec')
require('./app')
require('spec_helper')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new list', {:type => :feature}) do
  it('allows a user to click a list to see the tasks and details') do
    visit('/')
    click_link('Add a list')
    fill_in('list_name', :with => 'Wash the Pig')
    click_button('Create List')
    expect(page).to have_content('Success')
  end
end

describe('viewing lists', {:type => :feature}) do
  it('allows a user to see all of our lists') do
    list = List.new({:name => 'Pig feeding', :id => nil})
    list.save()
    visit('/')
    expect(page).to have_content(list.name)
  end
end

describe('seeing details for a single list', {:type => :feature}) do
  it('allows a user to see all tasks for one list') do
    test_list = List.new({:name => "Pig Schedule", :id => nil})
    test_list.save()
    test_task = Task.new({:description => "Monday: Bob and feeds and scoops", :list_id => test_list.id()})
    test_task.save()
    visit('/')
    click_link(test_list.name())
    expect(page).to have_content(test_task.description())
  end
end

describe('adding tasks to a list', {:type => :feature}) do
  it('allows a user to add a task to a list') do
    test_list = List.new({:name => "Pig Names", :id => nil})
    test_list.save()
    test_task1 = Task.new({:description => "Souie", :list_id => test_list.id()})
    test_task1.save()
    test_task2 = Task.new({:description => "Souie", :list_id => test_list.id()})
    test_task2.save()
    expect(test_list.get_tasks()).to(eq([test_task1, test_task2]))
  end
end
