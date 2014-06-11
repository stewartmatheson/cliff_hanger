class Binding
  def ch
    f = CliffHanger::MainForm.new(self)
    puts "Now Cliff Hanging"
    while f.isVisible
    end
  end
end
