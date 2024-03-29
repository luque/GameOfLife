Class {
	#name : #GoLGrid,
	#superclass : #BlElement,
	#instVars : [
		'model'
	],
	#category : #'GameOfLife-View'
}

{ #category : #accessing }
GoLGrid class >> backgroundColor [
	^ Color veryVeryLightGray
]

{ #category : #'instance - creation' }
GoLGrid class >> withContents: anArray2D ofSize: aPoint [
	^ self new initializeWithContents: anArray2D ofSize: aPoint
]

{ #category : #accessing }
GoLGrid >> initialize [
	super initialize.
	self
		background: self class backgroundColor;
		layout: (BlGridLayout vertical cellSpacing: 2);
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ]
]

{ #category : #initialization }
GoLGrid >> initializeWithContents: anArray2D ofSize: aPoint [
	| cells |
	cells := anArray2D
			collect: [ :each | each = 1 ifTrue: [ GoLAliveGridCell new ] ifFalse: [ GoLDeadGridCell new ] ].
	^ self
		layoutDo: [ :aGridLayout | aGridLayout rowCount: anArray2D rowCount ];
		addChildren: cells asArray;
		yourself
]

{ #category : #accessing }
GoLGrid >> model [
	^ model
]

{ #category : #accessing }
GoLGrid >> model: aModel [
	model := aModel.
	self subscribeToModelAnnouncements.
]

{ #category : #'event - handling' }
GoLGrid >> onNextGeneration: aGameOfLifeNextGenerationAnnouncement [
	self updateWithContents: self model currentGeneration
]

{ #category : #'event - handling' }
GoLGrid >> subscribeToModelAnnouncements [
	model announcer when: GoLGameOfLifeNextGeneration send: #onNextGeneration: to: self
]

{ #category : #initialization }
GoLGrid >> updateWithContents: anArray2D [
	| newGenerationCells |
	newGenerationCells := (anArray2D
			collect: [ :each | each = 1 ifTrue: [ GoLAliveGridCell new ] ifFalse: [ GoLDeadGridCell new ] ])
			asArray.
	self children
		doWithIndex: [ :aChild :index | 
			(newGenerationCells at: index) = aChild
				ifFalse: [ self removeChild: aChild.
					self addChild: (newGenerationCells at: index) at: index ] ]
]
