class JavaProp
  attr :file, :properties
  
  #Takes aArray.new(10) { iii } file and loads the properties in that file
  def initialize file
    @file = file
    @properties = JHash.new 
    IO.foreach(file) do |line|
      if !line.strip.start_with? '#'
      @properties[$1.strip] = $2 if line =~ /([^=]*)=(.*)[\/]*(.*)/ || line =~ /([^=]*)=(.*)/ 
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

  #Save the properties back to file  (not idempotent)
  def save! new_dir=@file
    begin
      @file="#{new_dir}"
      file = File.new(@file,"w+")
        @properties.each { |key,value| 
          file.write "#{key}=#{value}\n" 
         }
      
    rescue
        raise 'cannot save file'
    end
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
       #modifies to string to be more applicable for .properties file
        def to_s
            string_out=''
                if self.size >1
                   self.each_pair {|key,val| string_out+="#{key}=#{val}\n"}
                else
                    string_out="#{self.keys[0]}=#{self.values[0]}"
                end
            return string_out
        end

        def swap_key find, rep
            i=self.keys.index find
            split=self.split i
            split[0][rep]=split[1].delete(find)
            self.replace(split[0].merge(split[1]))
        end

        def split arg
            h1=JHash.new
            h2=JHash.new
            self.keys[0...arg].each { |key|
                h1[key]=self[key]
                }
            self.keys[arg..self.size].each { |key|
                h2[key]=self[key]
                }
            return [h1,h2]
        end
    end
 
end
