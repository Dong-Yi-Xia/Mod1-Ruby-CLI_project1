
class Loading
   

    def self.font
        TTY::Font.new(:doom, letter_spacing: 4)
    end
   

    def self.frame_01
        puts font.write("L").colorize(:green)
        sleep (0.10)
        system 'clear'
    end

    def self.frame_02
        puts font.write("LO").colorize(:green)
        sleep (0.10)
        system 'clear'
    end

    def self.frame_03
        puts font.write("LOA").colorize(:green)
        sleep (0.10)
        system 'clear'
    end

    def self.frame_04
        puts font.write("LOAD").colorize(:green)
        sleep (0.10)
        system 'clear'
    end

    def self.frame_05
        puts font.write("LOADI").colorize(:green)
        sleep (0.10)
        system 'clear'
    end

    def self.frame_06
        puts font.write("LOADIN").colorize(:green)
        sleep (0.10)
        system 'clear'
    end

    def self.frame_07
        puts font.write("LOADING").colorize(:green)
        sleep (0.10)
        system 'clear'
    end

    def self.frame_08
        puts font.write("LOADING .").colorize(:green)
        sleep (0.10)
        system 'clear'
    end

    def self.frame_09
        puts font.write("LOADING ..").colorize(:green)
        sleep (0.10)
        system 'clear'
    end

    def self.frame_10
        puts font.write("LOADING ...").colorize(:green)
        sleep (0.10)
        system 'clear'
    end

    def self.animation
        3.times do
          Loading.frame_01
          Loading.frame_02
          Loading.frame_03
          Loading.frame_04
          Loading.frame_05
          Loading.frame_06
          Loading.frame_07
          Loading.frame_08
          Loading.frame_09
          Loading.frame_10  
        end
      end

      def self.go
        system 'clear'
        self.animation
      end


end

