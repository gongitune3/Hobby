class Users::SearchController < ApplicationController
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
            Book.where(title: content)
          elsif method == 'forward'
            Book.where('title LIKE ?', content+'%')
          elsif method == 'backward'
            Book.where('title LIKE ?', '%'+content)
          else
            Book.where('title LIKE ?', '%'+content+'%')
          end
        end
      end
end
