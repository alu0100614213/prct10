require "matriz_sf/version"

module Matriz_sf
	class Matriz
	    
		def initialize(f=0,c=0)
		    @fil = f
		    @col = c
		end

		attr_accessor :fil,:col
	
		##Declarar metodos abstactos
	 	def to_s
		    raise "Error. metodo no definido."
		end
		    
		def +(b)
		    raise "Error. metodo no definido."
		end
		
		def -(b)
		    raise "Error. metodo no definido."
		end
		
		def *(b)
		    raise "Error. metodo no definido."
		end
		
		def /(b)
		    raise "Error. metodo no definido."
		end
	end
	    
	  class VectorDisperso
		    attr_reader :vector
		    
		    def initialize(h = {})
		      @vector = Hash.new(0)
		      @vector = @vector.merge!(h)
		    end
		    
		    def [](j)
		      @vector[j]
		    end

		    def to_s
		      @vector.to_s
		    end
	  end

	class MatrizDispersa < Matriz
		    attr_reader :matrix
		    
		    def initialize(h = {})
		      @matrix = Hash.new({})
		      for k in h.keys do 
			@matrix[k] = if h[k].is_a? Vectordisperso
				      h[k]
				    else 
				      @matrix[k] = Vectordisperso.new(h[k])
				    end
		      end
		    end

		    def [](i)
		      @matrix[i]
		    end

		    def col(j)
		      c = {}
		      for r in @matrix.keys do
			c[r] = @matrix[r].vector[j] if @matrix[r].vector.keys.include? j
		      end
		      Vectordisperso.new c
		    end
		    
		    
		    def to_s
		      str = @matrix.map {|k,v| "#{k} => #{v.to_s}"}.join(", ")
		      str = "{ #{str} }"
		    end
		    
		    def max
            maximo=@matrix[0]
            for i in (1..@matrix.length)
                if maximo < @matrix[i]
                    maximo=@matrix[i]
                end
            end
        end

        def min
            minimo=@matrix[0]
            for i in (1..@matrix.length)
                if minimo > @matrix[i]
                    minimo=@matrix[i]
                end
            end
        end
	  end

	class MatrizDensa < Matriz
		  def initialize (matrix, tam = matrix[0].size)
			 super(matrix.size,tam)
			 @matrix = matrix
			 @fila = matrix.size
			 @columna = tam
		  end
		  
		  attr_reader :matrix, :fila, :columna
			 
		  def mostrar #Funcion mostrar matriz
			 x = y = 0 # inicializamos las variables
			 puts "matriz: " 
			 while x < fila # primer bucle
			   while y < columna # segundo bucle
			print("#{matrix[x][y]}") #imprimimos en la posicion en la que se encuentre
			y += 1
			   end
			   puts
			   x += 1
			   y = 0
			 end
		  end
		  
		  def to_s #Funcion mostrar matriz
			 cadena = ""
			 x = y = 0 
			 while x < fila # primer bucle
			   while y < columna # segundo bucle
			cadena += "#{matrix[x][y]} "
			y += 1
			   end
			   cadena +="\n"
			   x += 1
			   y = 0
			 end
			 cadena
		  end
		  
			 
		  def +(o)
			 raise unless (o.is_a? Matriz) and (fila == o.fila) and (columna == o.columna)
			   mat = []
			   x = y = 0
			   while x < fila
			while y < columna
			  if y == 0
				 mat << [matrix[x][y] + o.matrix[x][y]]
			  else
				 mat[x] << (matrix[x][y] + o.matrix[x][y])
			  end
			  y += 1
			end
			x += 1
			y = 0
			   end
			   Matriz.new(mat)
		  end
		  
		  def *(o)
			 raise unless (o.is_a? Matriz) and (columna == o.fila) 
			 mat = Array.new(fila) { Array.new(o.columna) }
			   for i in 0...@fila do
			for j in 0...o.columna do
			  mat[i][j]=Fraccion.new(0,1);
			  for k in 0...o.fila do
				 mat[i][j] += matrix[i][k] * o.matrix[k][j]
			  end
			end
			   end
			   Matriz.new(mat)
		  end
	end 

	class Fraccion  #Clase Fraccion
		 include Comparable
		 attr_accessor :numerador, :denominador
		 
		 def initialize(num, den)
		 if den < 0
		num = -num
		den = -den
		   end
		   if num.kind_of?(Integer) and den.kind_of?(Integer)
		@numerador = num
		@denominador = den
		   else
		@numerador = num.to_i
		@denominador = den.to_i
		   end
		   max=gcd(@numerador,@denominador)
		   @numerador=@numerador/max
		   @denominador=@denominador/max
		 end
		 
		 def to_s      #devuelve fraccion formato a/b
		   if @denominador == 1
		@numerador.to_s
		   else
		@numerador.to_s+"/"+@denominador.to_s
		   end
		 end
		 
		 def numRacional   #Devuelve formato flotante
		   @numerador/@denominador
		 end  
		 
		 def gcd(u, v)  #Devuelve maximo como un divisor
		   u, v = u.abs, v.abs
		   while v != 0
		u, v = v, u % v
		   end
		   u
		 end
		 
		 def ==(o)
		   begin
		return ((@numerador == o.numerador) and (@denominador == o.denominador)) if o.instance_of? Fraccion
		false
		   rescue
		false
		   end
		 end
		 
		 def abs
		   Fraccion.new(@numerador.abs, @denominador.abs)
		 end
		 
		 def reciprocal
		   Fraccion.new(@denominador, @numerador)
		 end
		 
		 def -@
		   Fraccion.new(-@numerador, @denominador)
		 end
	  
		 
		 def +(o)
	  #     if o.is_a(FixNum)
	  #       o=Fraccion.new(o,1)
	  #     end  
		   Fraccion.new(@numerador*o.denominador + o.numerador*@denominador, @denominador*o.denominador)
		 end
		 
		 def -(o)
		   Fraccion.new(@numerador*o.denominador - o.numerador*@denominador, @denominador*o.denominador)
		 end
		 
		 def *(o)
		 if o.is_a?(Fixnum)
		   o=Fraccion.new(o,1)
		 end
		   Fraccion.new(@numerador*o.numerador,@denominador*o.denominador)
		 end
		 
		 def /(o)
		   Fraccion.new(@numerador*o.denominador,@denominador*o.numerador)
		 end
		 
		 def %(o)
		   Fraccion.new(@numerador%@denominador, o.numerador%o.denominador)
		 end
		 
		 def <=>(o)
		   return nil unless o.instance_of? Fraccion
		   (@numerador.to_f / @denominador) <=> (o.numerador.to_f / o.denominador)
		 end  
	end    
end
