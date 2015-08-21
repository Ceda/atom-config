blockTravel = (editor, direction, select) ->
  up        = direction == "up"
  lineCount = editor.getScreenLineCount()
  row       = editor.getCursorScreenPosition().row
  count     = 0

  loop
    count += 1

    if up
      rowIndex = row - count
    else
      rowIndex = row + count

    if rowIndex < 0
      count = row
      break
    else if rowIndex >= lineCount
      count = lineCount - row
      break

    if editor.lineTextForScreenRow(rowIndex).replace(/^\s+|\s+$/g, "") is ""
      break

  if select
    if up
      editor.selectUp(count)
    else
      editor.selectDown(count)
  else
    if up
      editor.moveUp(count)
    else
      editor.moveDown(count)

module.exports =
  activate: ->
    atom.commands.add 'atom-text-editor', 'block-travel:move-up', ->
      blockTravel(atom.workspace.getActivePaneItem(), "up", false)

    atom.commands.add 'atom-text-editor', 'block-travel:move-down', ->
      blockTravel(atom.workspace.getActivePaneItem(), "down", false)

    atom.commands.add 'atom-text-editor', 'block-travel:select-up', ->
      blockTravel(atom.workspace.getActivePaneItem(), "up", true)

    atom.commands.add 'atom-text-editor', 'block-travel:select-down', ->
      blockTravel(atom.workspace.getActivePaneItem(), "down", true)

  blockTravel: blockTravel
