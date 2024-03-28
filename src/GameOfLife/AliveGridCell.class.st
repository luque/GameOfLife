Class {
	#name : #AliveGridCell,
	#superclass : #GridCell,
	#category : #'GameOfLife-View'
}

{ #category : #accessing }
AliveGridCell >> backgroundColor [
	^ Color lightBlue
]

{ #category : #accessing }
AliveGridCell >> isAlive [
	^ true
]
