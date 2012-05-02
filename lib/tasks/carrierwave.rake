require "#{Rails.root}/config/environment.rb"

namespace :carrierwave do

  task :destroy, :class, :mount_uploader, :version do |task,args|
    desc "Destroy one image version"
    eval(args[:class]).all.each do |r|
      r.instance_eval(args[:mount_uploader].to_sym).instance_eval(args[:version].to_sym).remove!
    end
  end

  task :refresh, :class, :mount_uploader do |task,args|
    desc "refresh all images"
    eval(args[:class]).all.each do |r|
      attribute = args[:mount_uploader]
      r.update_attributes( attribute=>r.instance_eval(attribute) )

      file = r.instance_eval(attribute)
      if (File.dirname(file.path) rescue false)
        Dir[ File.dirname(file.path)+"/*" ].each do |r|
          if !file.class.versions.keys.include?( r.gsub("_#{file.file.original_filename}","").split("/").last.to_sym )  && r.split("/").last!=file.file.original_filename
            puts "Destroying: #{r}"
            File.delete r
          end
        end
      end
    end
  end

end

#Run
#rake carrierwave:refresh class=ProductPicture mount_uploader=picture