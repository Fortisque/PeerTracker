require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

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

RSpec.describe UsersController, type: :controller do


  before(:each) do
    DatabaseCleaner.clean
    @professor = create(:professor)
    @professor.add_role :professor
    @student = create(:student)
    @student.add_role :student
    @instructor = create(:instructor)
    @instructor.add_role :instructor
    @course = create(:course)
    @team = create (:team)
    sign_in @professor
  end
  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {user_id: 30000001, course_id: 1}
  }

  let(:invalid_attributes) {
    {user_id: 30000006, course_id: 1}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.
  let(:valid_session) { {current_user: @professor} }

  describe "GET #index" do
    context "for different roles" do
      let(:course) {
        stub_model(Course) {|course| course.id = 1; course.course_name = "WOW"; course.user_id = 20000001; }
      }
      it "as a student" do
        sign_in @student
        get :index
        expect(response).to redirect_to(courses_url)
      end
      it "as a professor" do
        get :index, {}, valid_session
        expect(assigns(:courses)).to eq([course]) 
      end
      it "as an instructor" do
        sign_in @instructor
        course.users << @student
        course.users << @instructor
        @team.users << @student
        @team.users << @instructor
        get :index, {}, valid_session
        expect(assigns(:courses)).to eq([course]) 
        expect(assigns(:users)).to eq([@student])
      end
    end
  end
  describe "POST #create" do
    context "with valid params" do 
      it "add a student to a course" do
        expect {
          post :create, {:user => valid_attributes}, valid_session
        }.to change(@student.courses, :count).by(1)
      end

      it "add a course to a student" do
        expect {
          post :create, {:user => valid_attributes}, valid_session
        }.to change(@course.users, :count).by(1) 
      end
    end

    context "with invalid params" do
      it "not add a nonexisting student to a course" do
        expect {
          post :create, {:user => invalid_attributes}, valid_session
        }.to change(@course.users, :count).by(0) 
      end
      it "not add an already enrolled student to a course" do
        expect {
          post :create, {:user => valid_attributes}, valid_session
          post :create, {:user => valid_attributes}, valid_session
        }.to change(@course.users, :count).by(1) 
      end

    end
  end

 
  describe "DELETE #destroy" do
    before(:each) do
      post :create, {:user => valid_attributes}, valid_session
    end
    it "removes the student to a class" do
      expect {
        delete :destroy, {:id => @student.id, :course_id => @course.id}, valid_session
      }.to change(@course.users, :count).by(-1)
    end

    it "redirects to the users list" do
      delete :destroy, {:id => @student.id, :course_id => @course.id}, valid_session
      expect(response).to redirect_to(users_url)
    end
  end

end
