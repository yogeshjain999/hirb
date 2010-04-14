require File.join(File.dirname(__FILE__), 'test_helper')

context "object table" do
  def table(*args)
    Helpers::ObjectTable.render(*args)
  end

  before_all {
    @pets = [stub(:name=>'rufus', :age=>7, :to_s=>'rufus'), stub(:name=>'alf', :age=>101, :to_s=>'alf')]
  }
  test "renders" do
    expected_table = <<-TABLE.unindent
    +-------+-----+
    | name  | age |
    +-------+-----+
    | rufus | 7   |
    | alf   | 101 |
    +-------+-----+
    2 rows in set
    TABLE
    table(@pets, :fields=>[:name, :age]).should == expected_table
  end
  
  test "with no options defaults to to_s field" do
    expected_table = <<-TABLE.unindent
    +-------+
    | value |
    +-------+
    | rufus |
    | alf   |
    +-------+
    2 rows in set
    TABLE
    table(@pets).should == expected_table
  end

  test "renders simple arrays" do
    expected_table = <<-TABLE.unindent
    +-------+
    | value |
    +-------+
    | 1     |
    | 2     |
    | 3     |
    | 4     |
    +-------+
    4 rows in set
    TABLE
    table([1,2,3,4]).should == expected_table
  end

  test "renders simple arrays with custom header" do
    expected_table = <<-TABLE.unindent
    +-----+
    | num |
    +-----+
    | 1   |
    | 2   |
    | 3   |
    | 4   |
    +-----+
    4 rows in set
    TABLE
    table([1,2,3,4], :headers=>{:to_s=>'num'}).should == expected_table
  end

  test "with empty fields" do
    expected_table = <<-TABLE.unindent
    0 rows in set
    TABLE
    table(@pets, :fields => []).should == expected_table
  end
end