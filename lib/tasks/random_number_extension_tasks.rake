namespace :radiant do
  namespace :extensions do
    namespace :random_number do
      
      desc "Runs the migration of the Random Number extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          RandomNumberExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          RandomNumberExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Random Number to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from RandomNumberExtension"
        Dir[RandomNumberExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(RandomNumberExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
