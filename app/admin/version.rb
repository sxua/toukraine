# encoding: utf-8

ActiveAdmin.register Version, :as => "Latest changes" do
  
  menu :parent => "Users"
    
  index do
    column "Тип объекта" do |v| v.item_type.underscore.humanize end
      
    column "Объект"  do |v| 
      if v.item && %w{page photo promotion background tour tour_type admin_user city region sight}.include? v.item_type.underscore
        link_to v.item.id, self.send("admin_#{v.item_type.underscore}_path", v.item)
      else
        " - "
      end
    end
    
    column :event
    
    column "Кто менял" do |v| 
      user = AdminUser.find_by_id(v.whodunnit)
      if user
        link_to user.email, admin_admin_user_path(user)
      end
    end
    
    column "Когда" do |v| v.created_at.to_s :long end
    default_actions
  end

  filter :item_type
end
