ActiveAdmin.register Denuncia do

  scope :all, :default => true
  scope :finalizadas
  scope :abiertas

  controller do
    def scoped_collection
      resource_class.includes(:dependencia)
    end
  end

  # Descomentar la siguiente linea en caso de querer evitar el 'destroy' en batch
  # batch_action :destroy, false

  batch_action :finalizar do |selection|
    Denuncia.find(selection).each { |denuncia| denuncia.cerrar }
    redirect_to collection_path, :notice => "Denuncias marcadas como finalizadas."
  end

  batch_action :abrir do |selection|
    Denuncia.find(selection).each { |denuncia| denuncia.abrir }
    redirect_to collection_path, :notice => "Denuncias marcadas como abiertas."
  end

  member_action :cambiar_estado, :method => :put do
    denuncia = Denuncia.find(params[:id])
    denuncia.cambiar_estado
    redirect_to :action => :show
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
      row 'Estado', :finalizada do
        status_tag (denuncia.finalizada? ? 'Finalizada' : 'Abierta'), (denuncia.finalizada? ? :ok : :warning)
      end
      row :acciones do
        link_to 'Cambiar estado', cambiar_estado_admin_denuncia_path(denuncia), method: :put
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
