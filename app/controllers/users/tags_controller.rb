class Users::TagsController < ApplicationController
    def inedx
        @tags = Tag.all
    end

    def create
        tag = Tag.new(tag_params)
        tag.save
    end

    def destroy

    end
    private
    def tag_params
        params.require(:board).permit(:board_id, :name)
    end
end
