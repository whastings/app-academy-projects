require 'rspec'
require 'reply'

describe Reply do
  subject(:reply) { Reply.find_by_id(1) }

  describe "::find_by_user_id" do
    it "should find all replies by the user" do
      expect(Reply.find_by_user_id(2).first.id).to eq(2)
    end
  end

  describe "::find_by_question_id" do
    it "should find all replies for a question" do
      expect(Reply.find_by_question_id(1).length).to eq(2)
    end
  end

  describe '#child_replies' do
    it "should find all child replies for a reply" do
      expect(reply.child_replies.first.id).to eq(2)
    end
  end

  describe '#parent_reply' do
    subject(:reply) { Reply.find_by_id(2) }
    it "should find its parent reply" do
      expect(reply.parent_reply.id).to eq(1)
    end
  end

end
