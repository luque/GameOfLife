Class {
	#name : #GameOfLife,
	#superclass : #Object,
	#instVars : [
		'rows',
		'columns',
		'mouseInteraction',
		'currentGeneration',
		'nextGeneration',
		'cellSize',
		'numberGeneration',
		'announcer'
	],
	#category : #'GameOfLife-Core'
}

{ #category : #'life pattern - oscillators' }
GameOfLife class >> beacon [
	^ Array2D
		fromCollection: {
		        #(0 0 0 0 0 0).
				#(0 1 1 0 0 0).
				#(0 1 1 0 0 0).
				#(0 0 0 1 1 0).
				#(0 0 0 1 1 0).
				#(0 0 0 0 0 0)}
]

{ #category : #example }
GameOfLife class >> beaconExample [
	<gtExample>
	| game |
	game := self new
			initializeWithRows: 10
			columns: 10
			ofSize: 5 @ 5.
	game add: self beacon atRow: 4 column: 3.
	^ game view
]

{ #category : #'life pattern - oscillators' }
GameOfLife class >> blinker [
	^ Array2D
		fromCollection: {
				#(0 0 0).
				#(1 1 1).
				#(0 0 0)}
]

{ #category : #example }
GameOfLife class >> blinkerExample [
	<gtExample>
	| game |
	game := self new
			initializeWithRows: 10
			columns: 10
			ofSize: 5 @ 5.
	game
		add: self blinker
		atRow: 3
		column: 5.
	^ game view
]

{ #category : #example }
GameOfLife class >> emptyExample [
	<gtExample>
	| game |
	game := self new
			initializeWithRows: 10
			columns: 10
			ofSize: 5 @ 5.
	^ game view
]

{ #category : #example }
GameOfLife class >> oscillatorsExample [
	<gtExample>
	| game |
	game := self new
			initializeWithRows: 10
			columns: 10
			ofSize: 5 @ 5.
	game add: self blinker atRow: 1 column: 1.
	game add: self beacon atRow: 4 column: 4.
	^ game view
]

{ #category : #adding }
GameOfLife >> add: aPatternAsArray2D atRow: rowNumber column: columnNumber [
	currentGeneration
		atRows: columnNumber
		to: columnNumber + aPatternAsArray2D columnCount - 1
		columns: rowNumber
		to: rowNumber + aPatternAsArray2D rowCount - 1
		put: aPatternAsArray2D
]

{ #category : #announcements }
GameOfLife >> announce: anAnnouncement [
	self announcer announce: anAnnouncement
]

{ #category : #announcements }
GameOfLife >> announceNextGeneration [
	self announce: (GameOfLifeNextGeneration generation: numberGeneration)
]

{ #category : #accesing }
GameOfLife >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #view }
GameOfLife >> asElement [
	^ (Grid withContents: currentGeneration ofSize: cellSize)
		model: self;
		yourself
]

{ #category : #accessing }
GameOfLife >> atAllPut: value [
	"Set the value to all cells"
     content atAllPut: value.
]

{ #category : #accessing }
GameOfLife >> currentGeneration [
	^ currentGeneration
]

{ #category : #'event - handling' }
GameOfLife >> disableMouseInteraction [
	"Disables modifying the grid using a mouse click"
     mouseInteraction := false.
]

{ #category : #drawing }
GameOfLife >> drawOn: canvas [
	"Draws the game of life widget with the current state"

	| cellWidth cellHeight rectangle  cellColor cellValue|
	
	cellWidth :=   (self width) / columns.
	cellHeight :=   (self height) / rows.
      1 to: rows do: [ :row |
	       1 to: columns do: [ :column |
		      cellValue := (content at: row at: column).
		      cellColor := cellValue = 1 ifTrue: [ Color black ] ifFalse: [ Color white  ].
                  rectangle := Rectangle left: (self bounds left) + ((column - 1)*cellWidth) 
                                                      right: (self bounds left) + ((column - 1)*cellWidth) + cellWidth
                                                      top: (self bounds top) + ((row - 1)*cellHeight )
                                                      bottom: (self bounds top) + ((row - 1)*cellHeight ) + cellHeight.
         
		      cellValue = 1 ifTrue: [canvas fillRectangle:  rectangle color:  cellColor]
		                           ifFalse: [canvas frameAndFillRectangle: rectangle 
			                                              fillColor:  (Color white) 
			                                              borderWidth: 1 
			                                              borderColor: (Color black)].
             ]
       ].
  	^self.
]

{ #category : #'event - handling' }
GameOfLife >> enableMouseInteraction [
     mouseInteraction := true.
]

{ #category : #accessing }
GameOfLife >> getCellValue: row column: column [
	"Gets the value of the specified cell"
      ^ ((row < 1) | (row > rows) | (column > columns) | (column < 1))
            ifTrue: [ 0 ]
            ifFalse: [ currentGeneration at: row at: column ] .
]

{ #category : #'game rules' }
GameOfLife >> getNextGenerationFor: row column: column [
	"Verifies the Game Of Life rules"

	| topLeft top topRight left right bottomLeft bottomRight bottom neighbors |
	topLeft := self getCellValue: row - 1 column: column - 1.
	top := self getCellValue: row - 1 column: column.
	left := self getCellValue: row column: column - 1.
	right := self getCellValue: row column: column + 1.
	topRight := self getCellValue: row - 1 column: column + 1.
	bottomRight := self getCellValue: row + 1 column: column + 1.
	bottom := self getCellValue: row + 1 column: column.
	bottomLeft := self getCellValue: row + 1 column: column - 1.

	neighbors := topLeft + top + left + right + topRight + bottomRight + bottom
			+ bottomLeft.

	^ (currentGeneration at: row at: column) = 1
		ifTrue: [ neighbors < 2 | (neighbors > 3) ifTrue: [ 0 ] ifFalse: [ 1 ] ]
		ifFalse: [ neighbors = 3 ifTrue: [ 1 ] ifFalse: [ 0 ] ]
]

{ #category : #accessing }
GameOfLife >> handlesMouseDown: aEvent [
     ^mouseInteraction.
]

{ #category : #initialization }
GameOfLife >> initializeWithRows: rowCount columns: columnCount ofSize: aPoint [
	"Sets the row and column count of the grid"

	rows := rowCount.
	columns := columnCount.
	cellSize := aPoint.
	numberGeneration := 1.
	currentGeneration := Array2D rows: rows columns: columns.
	currentGeneration atAllPut: 0.
	nextGeneration := Array2D rows: rows columns: columns.
	^ self
]

{ #category : #'event - handling' }
GameOfLife >> mouseDown: anEvent [
	      |cellRow cellColumn valueToSet|  
	 
	      cellRow :=  (((anEvent cursorPoint y) - (self bounds top))/ self height ) asFloat * rows.
	      cellRow := cellRow truncated.
	      cellColumn :=(  ((anEvent cursorPoint x) - (self bounds left))/ self width) asFloat * columns.
	      cellColumn := cellColumn truncated.
            valueToSet :=  ((content at: (cellRow + 1) at: (cellColumn + 1)) = 0) ifTrue: [ 1 ] ifFalse: [ 0 ].
	      content at: (cellRow + 1) at: (cellColumn + 1) put: valueToSet.

	      self changed.
]

{ #category : #stepping }
GameOfLife >> step [
	"Verifies the rules of the Game Of Life"
	| tmp |

	1 to: rows do:  [ :row | 
		1 to: columns do:  [ :column |
			nextGeneration at: row at: column put: (self getNextGenerationFor: row column: column).
			 ]
      ].
      tmp := currentGeneration.
      currentGeneration := nextGeneration.
      nextGeneration := tmp.
      numberGeneration := numberGeneration + 1.
      self announceNextGeneration.
]

{ #category : #view }
GameOfLife >> view [
	^ self asElement
]
