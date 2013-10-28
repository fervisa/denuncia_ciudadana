ActiveAdmin.register Denuncia do

  scope :all, :default => true
  scope :finalizadas
  scope :abiertas

  controller do
    def scoped_collection
      resource_class.includes(:dependencia)
    end
  end

  index do
    selectable_column
    column 'Folio', :id
    column :dependencia, :sortable => 'dependencias.nombre'
    column 'Nombre del funcionario', :funcionario
    column 'Denunciante', :email
    column 'Creada en', :created_at
    column 'Estado', :finalizada do |denuncia|
      status_tag (denuncia.finalizada? ? 'Finalizada' : 'Abierta'), (denuncia.finalizada? ? :ok : :warning)
    end
    actions :defaults => false do |denuncia|
      link_to 'Detalles', admin_denuncia_path(denuncia)
    end
    # default_actions
  end

  show do |denuncia|
    attributes_table do
      row :id
      row :funcionario
      row :queja
      row :email
      row :dependencia
      row :created_at
      row :updated_at
      row :finalizada do
        status_tag (denuncia.finalizada? ? 'Finalizada' : 'Abierta'), (denuncia.finalizada? ? :ok : :warning)
      end
      row :adjuntos do
        ul :class => 'adjuntos' do
          denuncia.archivos.each do |archivo|
            li do
              link_to image_tag(archivo.adjunto.url(:thumb)), archivo.adjunto.url
            end
          end
        end
      end
    end
    active_admin_comments
  end
  
end
