class DenunciasController < ApplicationController
  before_filter :load_file_params, only: :create

  # GET /denuncias/1
  # GET /denuncias/1.json
  def show
    @denuncia = Denuncia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @denuncia }
    end
  end

  # GET /denuncias/new
  # GET /denuncias/new.json
  def new
    @denuncia = Denuncia.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @denuncia }
    end
  end

  # POST /denuncias
  # POST /denuncias.json
  def create
    @denuncia = Denuncia.new

    respond_to do |format|
      if @denuncia.finalize(params[:denuncia])
        format.html { redirect_to @denuncia, notice: 'Su denuncia ha sido creada exitosamente.' }
        format.json { render json: @denuncia, status: :created, location: @denuncia }
      else
        format.html { render action: "new" }
        format.json { render json: @denuncia.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def load_file_params
    return if params[:archivos].nil? || params[:archivos].empty?
    archivo_attributes = []
    params[:archivos].each do |archivo|
      archivo_attributes << { adjunto: archivo }
    end
    params[:denuncia][:archivos_attributes] = archivo_attributes
  end

end
