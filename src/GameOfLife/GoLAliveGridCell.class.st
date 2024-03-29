Class {
	#name : #GoLAliveGridCell,
	#superclass : #GoLGridCell,
	#category : #'GameOfLife-View'
}

{ #category : #accessing }
GoLAliveGridCell >> backgroundColor [
	^ Color lightBlue
]

{ #category : #accessing }
GoLAliveGridCell >> isAlive [
	^ true
]
