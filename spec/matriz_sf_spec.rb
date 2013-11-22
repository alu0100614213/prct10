require 'spec_helper'
include Matriz_sf



describe Matriz_sf do
  
   describe Matriz do
        before :all do
            MM = Matriz.new
        end
        
        describe "Matriz padre" do
            it 'Existe una clase abstracta Matriz?' do
                MM.instance_of?(Matriz) == true
            end
            it 'se puede acceder a los atributos (fila)?' do
                MM.fil.should == 0
            end

            it 'Existe metodo to_s ?' do
                MM.should respond_to("to_s")
            end
	
        end
	describe MatrizDensa do
	    before :all do 
		M1 = MatrizDensa.new([3,4],[5,6])
		
	    end
	    it 'Suma matriz dispersa y matriz densa' do
		M2 = MatrizDispersa.new(2,2,0 => { 0 => 1, 1 => 2}, 1 => { 0 => 3, 1 => 4})
		
		m = M1 + M2
		
		m[0][0].should eq(2)
                m[0][1].should eq(4)
                m[1][0].should eq(6)
                m[1][1].should eq(8)
	    end
	end
    end
 end
