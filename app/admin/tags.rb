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
        flash[:notice] = "Tag '#{tag.name}' successfully deleted"
      else
        flash[:error] = "Couldn't delete tag '#{tag.name}'. Is it currently being used by any Lab Record Import?"
      end
      redirect_to action: :index
    end
  end
end
