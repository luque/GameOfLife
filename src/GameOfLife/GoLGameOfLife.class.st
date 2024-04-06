Class {
	#name : #GoLGameOfLife,
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
GoLGameOfLife class >> beacon [
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
GoLGameOfLife class >> beaconExample [
	<gtExample>
	| game |
	game := self emptyGame.
	game add: self beacon atRow: 4 column: 3.
	^ game
]

{ #category : #'life pattern - oscillators' }
GoLGameOfLife class >> blinker [
	^ Array2D
		fromCollection: {
				#(0 0 0).
				#(1 1 1).
				#(0 0 0)}
]

{ #category : #example }
GoLGameOfLife class >> blinkerExample [
	<gtExample>
	| game |
	game := self emptyGame.
	game
		add: self blinker
		atRow: 3
		column: 5.
	^ game
]

{ #category : #example }
GoLGameOfLife class >> emptyGame [
	^ self new
		initializeWithRows: 10
		columns: 10
		ofSize: 5 @ 5
]

{ #category : #'life pattern - oscillators' }
GoLGameOfLife class >> glider [
	^ Array2D
		fromCollection: {
				#(0 1 0).
				#(0 0 1).
				#(1 1 1)}
]

{ #category : #accessing }
GoLGameOfLife class >> gliderExample [
	<gtExample>
	| game |
	game := self emptyGame.
	game add: self glider atRow: 1 column: 1.
	^ game
]

{ #category : #example }
GoLGameOfLife class >> oscillatorsExample [
	<gtExample>
	| game |
	game := self emptyGame.
	game add: self blinker atRow: 1 column: 1.
	game add: self beacon atRow: 4 column: 4.
	^ game
]

{ #category : #adding }
GoLGameOfLife >> add: aPatternAsArray2D atRow: rowNumber column: columnNumber [
	currentGeneration
		atRows: columnNumber
		to: columnNumber + aPatternAsArray2D columnCount - 1
		columns: rowNumber
		to: rowNumber + aPatternAsArray2D rowCount - 1
		put: aPatternAsArray2D
]

{ #category : #announcements }
GoLGameOfLife >> announce: anAnnouncement [
	self announcer announce: anAnnouncement
]

{ #category : #announcements }
GoLGameOfLife >> announceNextGeneration [
	self announce: (GoLGameOfLifeNextGeneration generation: numberGeneration)
]

{ #category : #accesing }
GoLGameOfLife >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #view }
GoLGameOfLife >> asElement [
	^ (GoLGrid withContents: currentGeneration ofSize: cellSize)
		model: self;
		yourself
]

{ #category : #accessing }
GoLGameOfLife >> currentGeneration [
	^ currentGeneration
]

{ #category : #generations }
GoLGameOfLife >> getNextGenerationFor: row column: column [
	"Verifies the Game Of Life rules"

	| neighbors |
	neighbors := currentGeneration numberAliveNeighborsAtRow: row column: column.

	^ (currentGeneration isAliveAtRow: row column: column)
		ifTrue: [ neighbors < 2 | (neighbors > 3) ifTrue: [ 0 ] ifFalse: [ 1 ] ]
		ifFalse: [ neighbors = 3 ifTrue: [ 1 ] ifFalse: [ 0 ] ]
]

{ #category : #accessing }
GoLGameOfLife >> gtLiveViewFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		stencil: [ self ];
		actionButtonIcon: BrGlamorousVectorIcons play
			action: [ :b :aTab | self play ];
		actionButtonIcon: BrGlamorousVectorIcons spawn
			action: [ :b :aTab | 
				self step.
				aTab viewContentElement phlow update ];
		actionButtonIcon: BrGlamorousVectorIcons pause
			action: [ :b :aTab | self stop ]
						
]

{ #category : #initialization }
GoLGameOfLife >> initializeWithRows: rowCount columns: columnCount ofSize: aPoint [
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
GoLGameOfLife >> play [
	isRunning := true.
	[ [ isRunning ]
		whileTrue: [ self step.
			250 milliSeconds wait ] ]
		forkAt: Processor userBackgroundPriority
		named: 'GameOfLife'
]

{ #category : #stepping }
GoLGameOfLife >> step [
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
GoLGameOfLife >> stop [
	isRunning := false.
]

{ #category : #view }
GoLGameOfLife >> view [
	^ self asElement
]
