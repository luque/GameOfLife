Class {
	#name : #GoLGridCell,
	#superclass : #BlElement,
	#category : #'GameOfLife-View'
}

{ #category : #initialization }
GoLGridCell class >> alive [
"	^ AliveGridCell new"
]

{ #category : #initialization }
GoLGridCell class >> dead [
"	^ DeadGridCell new"
]

{ #category : #accessing }
GoLGridCell >> backgroundColor [
	self subclassResponsibility
]

{ #category : #accessing }
GoLGridCell >> initialize [
	super initialize.
	self
		background: self backgroundColor;
		padding: (BlInsets all: 10);
		constraintsDo: [ :c | 
			c grid horizontal alignCenter.
			c grid vertical alignCenter ]
]

{ #category : #accessing }
GoLGridCell >> isAlive [
	self subclassResponsibility
]
