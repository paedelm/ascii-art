AsciiArtView = require './ascii-art-view'
{CompositeDisposable} = require 'atom'

module.exports = AsciiArt =
  asciiArtView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @asciiArtView = new AsciiArtView(state.asciiArtViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @asciiArtView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'ascii-art:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @asciiArtView.destroy()

  serialize: ->
    asciiArtViewState: @asciiArtView.serialize()

  toggle: ->
    console.log 'AsciiArt was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
