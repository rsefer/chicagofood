module WelcomeHelper

  def filterButtonOpenClose
    raw inline_icon('check', '', 'right') + inline_icon('circle', '', 'right')
  end

  def tryButtonHTML
    raw 'To Try' + self.filterButtonOpenClose
  end

  def byobButtonHTML
    raw inline_icon('beer', 'BYOB', 'left') + self.filterButtonOpenClose
  end

  def outdoorButtonHTML
    raw inline_icon('sun', 'Outdoor/Patio', 'left') + self.filterButtonOpenClose
  end

end
