class JavaProp
  attr :file, :properties
  
  #Takes aArray.new(10) { iii } file and loads the properties in that file
  def initialize file
    @file = file
    @properties = JHash.new 
    IO.foreach(file) do |line|
      if !line.strip.start_with? '#'
      @properties[$1.strip] = $2 if line =~ /([^=]*)=(.*)\/\/(.*)/ || line =~ /([^=]*)=(.*)/ 
      end
    end
  end

  #Helpfull to string  
  def to_s
     output = "#File Name #{@file} \n"
     @properties.each {|key,value| output += " #{key}= #{value} \n" }
     output
  end
  
  #Write a property
  def write_property (key,value)
    @properties[key] = value
  end

  #Save the properties back to file  
  def save!
    file = File.new(@file,"w+")
    file.puts self.to_s
    file.close
  end

  def get arg
    self.properties.get arg
  end  


#   add any additional functionality to the hashes used here
    private
    class JHash < Hash
        #gets all keys broken down by . delimeters
        def get(search_index)
            out=JHash.new
            self.keys.each do |key|
                if key.split('.')[0,search_index.count('.')+1].join('.') == search_index
                    out[key]=fetch(key,"")     
                end
            end
            out
        end
        def to_s
            string_out=''
                if self.size >1
                   self.each_pair {|key,val| string_out+="#{key}=#{val}\n"}
                else
                    string_out="#{self.keys[0]}=#{self.values[0]}"
                end
            return string_out
        end
    end
    

 
end

