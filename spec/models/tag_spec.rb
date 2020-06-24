require 'rails_helper'

RSpec.describe Tag, type: :model do
  context "タグが正しく保存される" do
    before do
      @tag = Tag.new(name: "tag_test")
      @tag.save
    end

    it "正しく保存される" do
      expect(@tag).to be_valid
    end
  end

  context "タグが正しく保存されない" do
    before do
      @tag = Tag.new(name: "")
      @tag.save
    end

    it "正しく保存されない" do
      expect(@tag).to be_invalid
    end
  end

  context "タグが正しく削除される" do
    before do
      @tag = Tag.new(name: "tag_test")
      @tag.save
      @tag.destroy
    end

    it "正しく削除される" do
      expect(@tag).to be_valid
    end
  end
end
