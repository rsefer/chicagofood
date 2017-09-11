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

  def craftbeerButtonHTML
    raw inline_icon('beer', 'Craft Beer', 'left') + self.filterButtonOpenClose
  end

  def cocktailsButtonHTML
    raw inline_icon('wine', 'Cocktails', 'left') + self.filterButtonOpenClose
  end

  def outdoorButtonHTML
    raw inline_icon('sun', 'Outdoor/Patio', 'left') + self.filterButtonOpenClose
  end

  def filterButtonClassConditional(conditional)
    "btn btn-#{ conditional ? 'success' : 'danger isHidden' }"
  end

end
