module CliffHanger

  import javax.swing.ListCellRenderer
  import javax.swing.JPanel
  import javax.swing.JList
  import javax.swing.border.EmptyBorder
  import java.awt.Color
  import java.awt.Dimension

  class ListRenderManager
    include ListCellRenderer

    def initialize
      @list_panels = {}
    end

    def getListCellRendererComponent *params
      list = params[0]
      code_run = params[1]
      index = params[2]

      return @list_panels[index] if @list_panels.has_key?(index)

      result_panel = create_result_panel code_run
      @list_panels[index] = result_panel

      result_panel
    end

    private

    def create_result_panel code_run
      panel = JPanel.new
      panel.setBorder(EmptyBorder.new(5,5,5,5))
      panel.setLayout(BorderLayout.new)

      # First lets create the original code panel and add it
      original_code_label = JLabel.new
      original_code_label.setVisible true
      original_code_label.setOpaque true
      original_code_label.setBackground Color.new(20,20,20)
      original_code_label.setForeground Color.new(160,160,160)
      original_code_label.setText code_run.code
      original_code_label.setBorder(EmptyBorder.new(5,5,5,5))
      panel.add original_code_label, BorderLayout::NORTH

      # now we need to create the output panel
      output_panel = create_output_panel(code_run)
      output_panel.setBorder(EmptyBorder.new(5,5,5,5))
      output_panel.setBackground Color.new(200,200,200)

      panel.add(
        output_panel,
        BorderLayout::CENTER
      )

      panel
    end

    def create_output_panel code_run
      return ArrayRenderer.new(code_run) if code_run.result.class == Array
      return ClassRenderer.new(code_run) if code_run.result.class == Class
      return BooleanRenderer.new(code_run) if code_run.result.class == Boolean

      # Fall back to string. Here we call our text renderer
      TextRenderer.new(code_run)
    end
  end
end
