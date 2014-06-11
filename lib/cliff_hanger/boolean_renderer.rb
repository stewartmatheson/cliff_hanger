module CliffHanger

  import javax.swing.JPanel
  import javax.swing.JTextArea

  class BooleanRenderer < JPanel
    def initialize code_run
      super true

      self.setLayout(BorderLayout.new)

      l = JTextArea.new
      l.setText(code_run.result ? "true" : "false")
      l.setVisible true
      l.setOpaque false
      l.setLineWrap true

      l.setForeground(Color.new(200, 0, 0)) if code_run.error

      l.setSize(Dimension.new(540,999999))
      l.setSize l.getPreferredSize()
      self.add l, BorderLayout::CENTER
    end
  end

end
