require('spec_helper')

describe(List) do
  describe('#save') do
    it('will save a list into the database') do
      test_list = List.new({:name => 'my to do list', :id => nil})
      test_list.save()
      expect(List.all()).to(eq([test_list]))
    end
  end
  describe('#==') do
    it('is the same list if it has the same name and id') do
      list1 = List.new({:name => "my test list", :id => nil})
      list2 = List.new({:name => "my test list", :id => nil})
      expect(list1).to(eq(list2))
    end
  end
  describe('.find') do
    it('locates a list by id and returns it') do
      test_list1 = List.new({:name => "test 1 list", :id => nil})
      test_list1.save()
      test_list2 = List.new({:name => "test 2 list", :id => nil})
      test_list2.save()
      expect(List.find(test_list2.id())).to(eq(test_list2))
    end
  end



end
