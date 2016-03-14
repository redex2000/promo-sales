module ApplicationHelper
  # Показывает сообщение в bootstrap-стиле
  def show_message(name, msg)
    classes = 'alert'
    case name
      when 'info'
        classes += ' alert-success'
      when 'error'
        classes += ' alert-danger'
      else
        classes += ' alert-success'
    end
    classes += ' fade in'
    makeup_str = content_tag :div, link_to('×', '#', class: 'close', data: {dismiss: 'alert'}, aria: {label: 'close'}) + msg, class: classes
  end
end
