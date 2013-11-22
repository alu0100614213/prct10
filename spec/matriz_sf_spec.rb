require "Matriz.rb"


describe Matriz do
  
  before :each do
    @m1 = Matriz.new([[1,2,3],[4,5,6]])
    @m2 = Matriz.new([[3,3,3],[3,3,3],[3,3,3]])
    @m3 = Matriz.new([[3,3,3],[3,3,3]])
    @f1 = Fraccion.new(4,8)
    @f2 = Fraccion.new(3,2)
    @f3 = Fraccion.new(5,2)
    
    @matriz1 =Matriz.new([[@f1,@f2],[@f3,@f1]])
       
    @matriz2 =Matriz.new([[@f2,@f2],[@f2,@f2]])
  end
  
  describe "Existe Metodo to string?" do
    it { @p1.should respond_to :to_s }
  end
  
  it "Se debe poder sumar dos matrices de enteros" do
    (@m1+@m3).matrix.inspect.should == "[[4, 5, 6], [7, 8, 9]]"
    (@matriz1+@matriz2).matrix.inspect.should == "[[2, 3], [4, 2]]"
  end
  
  it "Se debe poder multiplicar una matriz de Enteros" do
  #  (@m1*@m2).matrix.inspect.should == "[[18, 18, 18], [45, 45, 45]]"
    (@matriz1*@matriz2).matrix.inspect.should == "[[3, 3], [9/2, 9/2]]"
  end
  
end
   