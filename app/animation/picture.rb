class Image

    def self.title
        Catpix::print_image "app/picture/images.png",
        :limit_x => 1.0,
        :limit_y => 0,
        :center_x => true,
        :center_y => false,
        :bg => "white",
        :bg_fill => false,
        :resolution => "high"
    end



end

