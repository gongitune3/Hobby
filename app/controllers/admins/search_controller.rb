class Admins::SearchController < ApplicationController

      def search
            @model = params["search"]["model"]
            @content = params["search"]["content"]
            @method = params["search"]["method"]
            @records = search_for(@model, @content, @method)
      end

      private
      def search_for(model, content, method)
            if model == 'user'
              User.all.perfect_search(content, method)
                      .forward_search(content, method)
                      .backward_search(content, method)
                      .partial_search(content, method)
            elsif model == 'board'
              if method == 'perfect'
                Board.where(title: content)
              elsif method == 'forward'
                Board.where('title LIKE ?', content+'%')
              elsif method == 'backward'
                Board.where('title LIKE ?', '%'+content)
              else
                Board.where('title LIKE ?', '%'+content+'%')
              end
            elsif model == 'tag'
              if method == 'perfect'
                Tag.where(name: content)
              elsif method == 'forward'
                Tag.where('name LIKE ?', content+'%')
              elsif method == 'backward'
                Tag.where('name LIKE ?', '%'+content)
              else
                Tag.where('name LIKE ?', '%'+content+'%')
              end
            end
      end
end
