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
    end
 end