#
# Based on [jekyll-figure](https://github.com/paulrobertlloyd/jekyll-figure)
#

module Jekyll
  module Figure

    class FigureTag < Liquid::Block
      def initialize(tag_name, markup, tokens)
        @markup = markup
        super
      end

      def render(context)
        @caption = super

        # Gather settings
        site = context.registers[:site]
        page = context.registers[:page]
        converter = site.find_converter_instance(::Jekyll::Converters::Markdown)

        # Render any liquid variables
        markup = Liquid::Template.parse(@markup).render(context)

        # Extract tag attributes
        attributes = {}
        markup.scan(Liquid::TagAttributes) do |key, value|
          attributes[key] = value
        end

        @settings = site.config["jekyll-figure"]
        @img = attributes["img"]
        @class = attributes["class"]
        @alt = attributes["alt"]

        if @img.start_with? site.baseurl
          # absolute path do nothing
        elsif @img.start_with? '/assets'
          # needs base url still
          @img = "#{site.baseurl}/#{@img}"
        else
          # auto-magic requested figure-out what assets we should be looking at
          post_name = File.basename(page.url, ".*")
          @img="#{site.baseurl}/assets/image/#{post_name}/#{@img}"
        end 

        # Caption: convert markdown and remove paragraphs
        unless @caption.nil?
          #figure_caption = @caption.gsub!(/\A"|"\Z/, "")
          figure_caption = @caption.gsub(/<\/?p[^>]*>/, "").chomp
          figure_caption = "  <figcaption>#{figure_caption}</figcaption>\n"
        end

        # Class name(s)
        if @class.nil?
          @class = "default-caption"
        end
        figure_class = @class.gsub(/\A"|"\Z/, "")
        figure_class = " class\=\"#{figure_class}\""

        unless @alt.nil?
          @alt.gsub!(/^"|"$/, "")
          alt="alt=\"#{@alt}\""
        end

        if @img.nil?
          figure_main = converter.convert(super(context))
        else
          figure_main = "<img src='#{@img}' #{alt}/>\n"
        end

        # Content
        if @settings && @settings["paragraphs"] == false
          # Strip paragraphs
          figure_main = figure_main.gsub(/<\/?p[^>]*>/, "")
        end

        # Used to escape markdown parsing rendering
        markdown_escape = "\ "

        # Render <figure>
        figure_tag =  "<figure#{figure_class}>"
        figure_tag += "#{figure_main}"
        figure_tag += "#{figure_caption}"
        figure_tag += "</figure>"
      end
    end

  end
end

Liquid::Template.register_tag("figure", Jekyll::Figure::FigureTag)