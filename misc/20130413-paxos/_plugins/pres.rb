def once(tag)
  unless (@__once_executed__ ||= []).include? tag
    yield
    @__once_executed__ << tag
  end
end

module Jekyll
  class Post
    
    def grid_position
      pos = @site.posts.index(self)
      siz = Math::sqrt(@site.posts.size).ceil
      {
        "x" => 1000 * (pos % siz),
        "y" => 1000 * (pos / siz),
      }
    end

    once(:redefine_to_liquid) do
      alias __old_to_liquid to_liquid
      def to_liquid

        dat = self.data["data"]

        if dat.nil?
          self.data["data"] = self.grid_position
        end
        __old_to_liquid
      end
    end
    
  end
end

# module Jekyll
#   module MyFilter

#     def hogehoge(input)
#       input.to_s
#     end
    
#   end
# end

# Liquid::Template.register_filter(Jekyll::MyFilter)
