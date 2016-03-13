module ApplicationHelper
  # Показывает сообщение в bootstrap-стиле
  def show_message(name, msg)
    classes = '.alert'
    case name
      when :info
        classes += '.alert-success'
      when :error
        classes += '.alert-danger'
      else
        classes += '.alert-success'
    end
    "div Test"
  end
end
