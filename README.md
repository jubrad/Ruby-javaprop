#Java Properties for Ruby
(I know these have been made before)
##JavaProps

require 'java_prop'/n
prop=JavaProp.new 'file_name.properties'

####access by partial key ex:

prop.get('test')/n
{'test.1'=>'first_test','test.2'=>'second_test'}/n
/n
prop.get('test').to_s/n
test.1=first_test\ntest.2=second_test"/n

###save to file
prop.save! (saves to original file)/n
prop.save! dir (saves to given file)/n
prop.save (dir) idempotent version of the above /not yet implemented

