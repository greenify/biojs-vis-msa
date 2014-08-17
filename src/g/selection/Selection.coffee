_ = require "underscore"
Model = require("backbone").Model

# holds the current user selection
Selection = Model.extend
  defaults:
    type: "super"

RowSelection = Selection.extend
  defaults: _.extend {}, Selection::.defaults,
    type: "row"
    seqId: ""

  inRow: (seqId) ->
    seqId is @.get "seqId"

  inColumn: (rowPos) ->
    true

ColumnSelection = Selection.extend
  defaults: _.extend {}, Selection::.defaults,
    type: "column"
    xStart: -1
    xEnd: -1

  inRow: () ->
    true

  inColumn: (rowPos) ->
    xStart <= rowPos && rowPos <= xEnd

# pos is a mixin of column and row
# start with Row and only overwrite "inColumn" from Column
PosSelection = RowSelection.extend _.extend {},
_.pick(ColumnSelection,"inColumn"),
  defaults: _.extend {}, ColumnSelection::.defaults, RowSelection::.defaults,
    type: "pos"

module.exports.sel = Selection
module.exports.possel = PosSelection
module.exports.rowsel = RowSelection
module.exports.columnsel = ColumnSelection
