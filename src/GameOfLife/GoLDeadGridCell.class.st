Class {
	#name : #GoLDeadGridCell,
	#superclass : #GoLGridCell,
	#category : #'GameOfLife-View'
}

{ #category : #accessing }
GoLDeadGridCell >> backgroundColor [
	^ Color white
]

{ #category : #accessing }
GoLDeadGridCell >> isAlive [
	^ false
]
