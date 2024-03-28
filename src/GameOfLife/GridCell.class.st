Class {
	#name : #GridCell,
	#superclass : #BlElement,
	#category : #'GameOfLife-View'
}

{ #category : #initialization }
GridCell class >> alive [
"	^ AliveGridCell new"
]

{ #category : #initialization }
GridCell class >> dead [
"	^ DeadGridCell new"
]

{ #category : #accessing }
GridCell >> backgroundColor [
	self subclassResponsibility
]

{ #category : #accessing }
GridCell >> initialize [
	super initialize.
	self
		background: self backgroundColor;
		padding: (BlInsets all: 10);
		constraintsDo: [ :c | 
			c grid horizontal alignCenter.
			c grid vertical alignCenter ]
]

{ #category : #accessing }
GridCell >> isAlive [
	self subclassResponsibility
]
