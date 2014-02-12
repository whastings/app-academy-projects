require 'rspec'
require 'user'

describe User do
  subject(:user) { User.find_by_id(3) }

  describe "#average_karma" do
    it "should show the average likes per question for a user" do
      expect(user.average_karma).to eq(1.0)
    end
  end

  describe "#save" do
    before(:all) do
      @new_user = User.new('fname' => "Tutes", 'lname' => "Butes")
    end
    context "#create" do
      it "should add the user to the database" do
        expect(@new_user.id).to be_nil
        @new_user.save
        last_user_id = QuestionsDatabase.instance.last_insert_row_id
        expect(@new_user.id).to eq(last_user_id)
      end
    end

    context "#update" do
      it "should update the user in the database" do
        @new_user.first_name = 'Robert'
        @new_user.save
        user_from_database = User.find_by_id(@new_user.id)
        expect(user_from_database.first_name).to eq('Robert')
      end
    end
  end
end
