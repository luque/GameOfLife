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
		'announcer',
		'isRunning'
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
	game := self emptyGame.
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
	game := self emptyGame.
	game
		add: self blinker
		atRow: 3
		column: 5.
	^ game view
]

{ #category : #example }
GameOfLife class >> emptyGame [
	^ self new
		initializeWithRows: 10
		columns: 10
		ofSize: 5 @ 5
]

{ #category : #example }
GameOfLife class >> oscillatorsExample [
	<gtExample>
	| game |
	game := self emptyGame.
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
GameOfLife >> currentGeneration [
	^ currentGeneration
]

{ #category : #generations }
GameOfLife >> getNextGenerationFor: row column: column [
	"Verifies the Game Of Life rules"

	| neighbors |
	neighbors := currentGeneration numberAliveNeighborsAtRow: row column: column.

	^ (currentGeneration isAliveAtRow: row column: column)
		ifTrue: [ neighbors < 2 | (neighbors > 3) ifTrue: [ 0 ] ifFalse: [ 1 ] ]
		ifFalse: [ neighbors = 3 ifTrue: [ 1 ] ifFalse: [ 0 ] ]
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

{ #category : #lifecycle }
GameOfLife >> play [
	isRunning := true.
	[ [ isRunning ]
		whileTrue: [ self step.
			500 milliSeconds wait ] ]
		forkAt: Processor userBackgroundPriority
		named: 'GameOfLife'
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

{ #category : #lifecycle }
GameOfLife >> stop [
	isRunning := false.
]

{ #category : #view }
GameOfLife >> view [
	^ self asElement
]
