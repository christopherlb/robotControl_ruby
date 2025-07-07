# Defines a proxy class to handle I/O for abstraction and testability. It is critical to keep this
# class small, so the amount of non-unit testable logic is kept to a minimum.
class IOProxy
  def puts(message)
    Kernel.puts(message)
  end

  def gets
    Kernel.gets
  end
end
