require "matriz_sf.rb"
include Matriz_sf

describe Matriz_sf do
  
   describe Matriz do
        before :all do
            MM = Matriz.new
        end
        
        describe "Basic" do
            it 'Existe una clase abstracta Matriz?' do
                MM.instance_of?(Matriz) == true
            end
            it 'se puede acceder a los atributos (fila)?' do
                MM.fila.should == 0
            end

            it 'Existe metodo to_s abstracto?' do
                MM.should respond_to("to_s")
            end

        end
    end
 end