require "matriz_sf/version"

module Matriz_sf
    class Matriz
        
        def initialize(f=0,c=0)
            @fil = r
            @col = c
        end

        attr_accessor :fila,:col
	
	##Declarar metodos abstactos
    end

  class Vectordisperso
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

  class Matrizdispersa
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