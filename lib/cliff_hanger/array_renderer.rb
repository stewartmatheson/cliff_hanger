module CliffHanger

  import javax.swing.JPanel
  import javax.swing.JLabel
  import javax.swing.BoxLayout


  class ArrayRenderer < JPanel
    def initialize code_run
      super true
      self.setLayout(BoxLayout.new(self, BoxLayout::PAGE_AXIS))

      code_run.result.each do |item|
        i = JLabel.new
        i.setText item
        i.setVisible true
        self.add i
      end
    end
  end
end
