require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe DenunciasController do

  # This should return the minimal set of attributes required to create a valid
  # Denuncia. As you add validations to Denuncia, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { 'funcionario' => 'Nombre Funcionario', 'queja' => 'Descripcion de la denuncia', 'email' => 'denunciante@mail.com', dependencia_id: dependencia.id}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # DenunciasController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  let(:dependencia) { FactoryGirl.create :dependencia }

  describe "GET index" do
    it "returns http error" do
      expect { get :index }.to raise_error
    end
  end

  describe "GET new" do
    it "returns http success" do
      response.should be_success
    end

    it "assigns a newly build denuncia as @denuncia" do
      get :new, valid_session
      assigns(:denuncia).should be_a(Denuncia)
      assigns(:denuncia).should_not be_persisted
    end

    it "renders the build denuncia to create" do
      get :new, valid_session
      response.should render_template 'new'
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created denuncia as @denuncia" do
        post :create, {:denuncia => valid_attributes}, valid_session
        assigns(:denuncia).should be_a(Denuncia)
      end

      it "creates a new Denuncia" do
        post :create, {:denuncia => valid_attributes}, valid_session
        assigns(:denuncia).should be_persisted
      end

      it "redirects to the created denuncia" do
        post :create, {:denuncia => valid_attributes}, valid_session
        response.should redirect_to(Denuncia.last)
      end

      it 'should render a notice message' do
        post :create, {:denuncia => valid_attributes}, valid_session
        flash[:notice].should == 'Su denuncia ha sido creada exitosamente.'
      end

      it 'should not contain errors' do
        post :create, {:denuncia => valid_attributes}, valid_session
        assigns(:denuncia).errors.should be_empty
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved denuncia as @denuncia" do
        # Trigger the behavior that occurs when invalid params are submitted
        Denuncia.any_instance.stub(:save).and_return(false)
        post :create, {:denuncia => { "funcionario" => "invalid value" }}, valid_session
        assigns(:denuncia).should be_a_new(Denuncia)
        assigns(:denuncia).should_not be_persisted
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Denuncia.any_instance.stub(:save).and_return(false)
        post :create, {:denuncia => { "funcionario" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end

    describe 'with attached files' do
      describe 'images' do
        before :each do
          @file_1 = fixture_file_upload('/files/image-1.png', 'image/png')
          @file_2 = fixture_file_upload('/files/image-2.png', 'image/png')
        end

        it 'saves the denuncia with attached images' do
          post :create, {:denuncia => valid_attributes, archivos: [@file_1, @file_2]}, valid_session
          assigns(:denuncia).should be_persisted
          assigns(:denuncia).archivos.length.should eq 2
          assigns(:denuncia).archivos[0].adjunto.to_s.should match /image-1.png/
          assigns(:denuncia).archivos[1].adjunto.to_s.should match /image-2.png/
        end
      end

      describe 'not images' do
        before :each do
          @file = fixture_file_upload('/files/file', 'text/plain')
        end

        it 'does not save the denuncia' do
          post :create, {:denuncia => valid_attributes, archivos: [@file]}, valid_session
          assigns(:denuncia).should_not be_persisted
          assigns(:denuncia).archivos.length.should eq 1
        end
      end

      describe 'mixed types' do
        before :each do
          @image = fixture_file_upload('/files/image-1.png', 'image/png')
          @file = fixture_file_upload('/files/file', 'text/plain')
        end

        it 'saves the denuncia with attached images' do
          post :create, {:denuncia => valid_attributes, archivos: [@image, @file]}, valid_session
          assigns(:denuncia).should_not be_persisted
          assigns(:denuncia).archivos.length.should eq 2
          assigns(:denuncia).errors.full_messages.length.should eq 1
          assigns(:denuncia).errors.full_messages[0].should match /allowed types: jpg, jpeg, gif, png/
        end
      end
    end
  end

  describe "PUT update" do
    it "returns http error" do
      expect { put :update }.to raise_error
    end
  end

  describe "GET show" do
    it "assigns the requested denuncia as @denuncia" do
      denuncia = Denuncia.new
      denuncia.finalize valid_attributes
      get :show, {:id => denuncia.to_param}, valid_session
      assigns(:denuncia).should eq(denuncia)
    end
  end

  describe "DELETE destroy" do
    it "returns http error" do
      expect { delete :destroy }.to raise_error
    end
  end
end
