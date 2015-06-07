{$, $$, layout} = window
{config, proxy} = window
{setBounds, getBounds} = remote.require './lib/utils'

changeBounds = ->
  bound = getBounds()
  {x, y} = bound
  borderX = bound.width - window.innerWidth
  borderY = bound.height - window.innerHeight
  newHeight = window.innerHeight
  newWidth = window.innerWidth
  if layout == 'horizonal'
    # Previous vertical
    newHeight = window.innerWidth / 800 * 480 + 30
    newWidth = window.innerWidth / 5 * 7
  else
    # Previous horizonal
    newHeight = window.innerWidth / 7 * 5 / 800 * 480 + 420
    newWidth = window.innerWidth / 7 * 5
  setBounds
    x: x
    y: y
    width: parseInt(newWidth + borderX)
    height: parseInt(newHeight + borderY)

window._layout = require "./layout.#{layout}"
window.addEventListener 'layout.change', (e) ->
  window._layout.unload()
  delete require.cache[require.resolve("./layout.#{layout}")]
  {layout} = e.detail
  changeBounds()
  window._layout = require "./layout.#{layout}"
