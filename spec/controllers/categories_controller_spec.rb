RSpec.describe CategoriesController, type: :controller do
  before(:each) do
    @request.env['HTTP_ACCEPT'] = 'application/json'
  end

  let(:images) do
    (1..4).collect { fixture_file_upload(File.join(Rails.root, 'spec/fixtures/images/test.png')) }
  end

  context '#index' do
    it 'should fetch all categories with status code 200' do
      get :index
      expect(response.status).to eq(200)
    end
    it 'should fetch all categories' do
      get :index
      expect(JSON.parse(response.body).count).to eq(Category.count)
    end
  end

  context '#show' do
    it 'should fetch a category' do
      category = FactoryGirl.create(:category)
      get :show, id: category.id
      expect(JSON.parse(response.body)['name']).to eq(category.name)
    end
  end

  context '#create' do
    before(:each) do
      @category = {
        name: 'Category 1',
        parent_id: FactoryGirl.create(:category).id,
        products_attributes: [{ name: 'Product 1' }, 2 => { name: 'Product 2' }]
      }
      @params = {
        category: @category,
        images: images }
    end

    it 'with valid parameters the controller should return 201 status code' do
      post :create, @params
      expect(response.status).to eq(201)
    end

    it 'after create the name should match' do
      post :create, @params
      expect(JSON.parse(response.body)['name']).to eq(@params[:category][:name])
    end

    it 'after create the parent_id should match' do
      post :create, @params
      expect(JSON.parse(response.body)['parent_id']).to eq(@params[:category][:parent_id])
    end

    it 'with empty parameters #create should raise ActionController::ParameterMissing error' do
      expect do
        post :create, {}
      end.to raise_error(ActionController::ParameterMissing)
    end

    it 'with no Category name, #create should raise ActionController::ParameterMissing error' do
      expect do
        post :create, @category.merge(name: nil)
      end.to raise_error(ActionController::ParameterMissing)
    end
  end

  context '#update' do
    before(:each) do
      @prev_name = 'Old Category'
      @updated_name = 'Updated Category'
      @parent_id = FactoryGirl.create(:category).id
      @category = FactoryGirl.create(:category, name: @prev_name)
      @updated_params = {
        id: @category.id,
        category: { name: @updated_name,
                    parent_id: @parent_id,
                    products_attributes: [{ name: 'Product 1' }, 2 => { name: 'Product 2' }]
                  },
        images: images
      }
    end

    it 'with valid parameters the #update action should return 201 status code' do
      post :update, @updated_params
      expect(response.status).to eq(201)
    end

    it 'after update the name should change' do
      post :update, @updated_params
      expect(JSON.parse(response.body)['name']).to eq(@updated_name)
    end

    it 'after update the parent_id should change' do
      post :update, @updated_params
      expect(JSON.parse(response.body)['parent_id']).to eq(@parent_id)
    end

    it 'with no category name, #update should return "can\'t be blank" message' do
      post :update, @updated_params.merge(category: { name: nil })
      expect(JSON.parse(response.body)['name'].first).to eq("can't be blank")
    end
  end

  context '#destroy' do
    it '#destroy returns nothing' do
      category = FactoryGirl.create(:category)
      post :destroy, id: category.id
      expect(response.status).to eq(204)
    end

    it 'destroy a category' do
      category = FactoryGirl.create(:category)
      post :destroy, id: category.id
      expect(Category.where(id: category.id).count).to eq(0)
    end
  end
end
