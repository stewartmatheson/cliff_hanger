module CliffHanger

  include Java

  import javax.swing.JFrame
  import javax.swing.JTextField
  import javax.swing.JLabel
  import javax.swing.JScrollPane
  import javax.swing.DefaultListModel
  import java.awt.event.KeyListener
  import java.awt.BorderLayout
  import java.awt.Insets

  class MainForm < JFrame
    def initialize binding
      super "Cliff Hanger!"
      @binding = binding
      @run_list = DefaultListModel.new
      @code_run_list = []
      @line_index = 0
      self.initUI

      @input.requestFocusInWindow
    end

    def initUI
      init_text_field
      init_list

      self.setSize 600, 900
      self.setDefaultCloseOperation JFrame::DISPOSE_ON_CLOSE
      self.setLocationRelativeTo nil
      self.setVisible true
    end

    def init_text_field
      @input = JTextField.new
      self.add @input, BorderLayout::PAGE_END
      @input.setVisible true
      @input.setBackground @background_color
      @input.setMargin Insets.new(5, 5, 5 ,5)

      @input.add_key_listener KeyListener.impl { |name, event|
        if event.keyCode == 10 && name == :keyPressed
          current_code_run = CodeRun.new(@input.getText, @binding)
          @run_list.addElement current_code_run
          @code_run_list.push current_code_run
          @input.text = ""
          @line_index = @code_run_list.length
        end

        if event.keyCode == 27 && name == :keyPressed
          self.dispose
        end

        up_pressed if event.keyCode == 38 && name == :keyPressed
        down_pressed if event.keyCode == 40 && name == :keyPressed
      }

    end

    def init_list
      @list = JList.new
      @list.setOpaque false
      @listScrollPane = JScrollPane.new(@list)
      self.add @listScrollPane, BorderLayout::CENTER
      @list.setVisible true
      @list.setModel @run_list
      @list.setCellRenderer(ListRenderManager.new)
    end

    def up_pressed
      return if @line_index == 0
      @line_index -= 1
      update_code_from_line_index
    end

    def down_pressed
      if @line_index == (@code_run_list.length - 1)
        @input.text = ""
        return
      end

      @line_index += 1
      update_code_from_line_index
    end

    def update_code_from_line_index
      @input.text = @code_run_list[@line_index].code
    end
  end
end
