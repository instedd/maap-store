ActiveAdmin.register Tag do
  permit_params :name

  index do
    id_column
    column :name
    column :created_at
    actions
  end

  filter :id
  filter :name
  filter :created_at

  controller do
    def destroy
      tag = Tag.find(params[:id])
      if tag.destroy
        redirect_to admin_tags_path, flash: { notice: "Tag successfully deleted" }
      else
        redirect_to admin_tags_path, flash: { error: "Couldn't delete tag. Is it currently being used by any Lab Record Import?" }
      end
    end
  end
end
