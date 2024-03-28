Class {
	#name : #Grid,
	#superclass : #BlElement,
	#instVars : [
		'model'
	],
	#category : #'GameOfLife-View'
}

{ #category : #accessing }
Grid class >> backgroundColor [
	^ Color veryVeryLightGray
]

{ #category : #'instance - creation' }
Grid class >> withContents: anArray2D ofSize: aPoint [
	^ self new initializeWithContents: anArray2D ofSize: aPoint
]

{ #category : #accessing }
Grid >> initialize [
	super initialize.
	self
		background: self class backgroundColor;
		layout: (BlGridLayout vertical cellSpacing: 2);
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ]
]

{ #category : #initialization }
Grid >> initializeWithContents: anArray2D ofSize: aPoint [
	| cells |
	cells := anArray2D
			collect: [ :each | each = 1 ifTrue: [ AliveGridCell new ] ifFalse: [ DeadGridCell new ] ].
	^ self
		layoutDo: [ :aGridLayout | aGridLayout rowCount: anArray2D rowCount ];
		addChildren: cells asArray;
		yourself
]

{ #category : #accessing }
Grid >> model [
	^ model
]

{ #category : #accessing }
Grid >> model: aModel [
	model := aModel.
	self subscribeToModelAnnouncements.
]

{ #category : #'event - handling' }
Grid >> onNextGeneration: aGameOfLifeNextGenerationAnnouncement [
	self updateWithContents: self model currentGeneration
]

{ #category : #'event - handling' }
Grid >> subscribeToModelAnnouncements [
	model announcer when: GameOfLifeNextGeneration send: #onNextGeneration: to: self
]

{ #category : #initialization }
Grid >> updateWithContents: anArray2D [
	| cells |
	cells := anArray2D
			collect: [ :each | each = 1 ifTrue: [ AliveGridCell new ] ifFalse: [ DeadGridCell new ] ].
	self removeChildren.
	self addChildren: cells asArray
]
