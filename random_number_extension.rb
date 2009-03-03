# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class RandomNumberExtension < Radiant::Extension
  version "0.1"
  description "Simple Radiant extension, adds tag <r:random_number> for generating random number"
  url "http://github.com/astashov/radiant-random-number-extension/tree/master"
  
  def activate
    Page.send :include, RandomNumberTags
  end
  
  def deactivate
  end
  
end
