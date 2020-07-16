class Users::TagsController < ApplicationController
    def inedx
        @tags = Tag.all
    end

    def create
        
    end
end
