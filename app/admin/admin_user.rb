ActiveAdmin.register AdminUser do
  index do
    column :email
    column :sign_in_count
    default_actions
  end
  
  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.buttons
  end
end