#Java Properties for Ruby
(I know these have been made before)
##JavaProps
```    
require 'java_prop'
prop=JavaProp.new 'file_name.properties'
``` 
###access by partial key ex:
```    
prop.get('test')
{'test.1'=>'first_test','test.2'=>'second_test'}
    
prop.get('test').to_s
test.1=first_test\ntest.2=second_test"
```    
###save to file
```    
prop.save! #(saves to original file)
prop.save! dir #(saves to given file)
prop.save (dir) # idempotent version of the above /not yet implemented
```    
