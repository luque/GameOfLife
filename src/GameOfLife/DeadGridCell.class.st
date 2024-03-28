Class {
	#name : #DeadGridCell,
	#superclass : #GridCell,
	#category : #'GameOfLife-View'
}

{ #category : #accessing }
DeadGridCell >> backgroundColor [
	^ Color white
]

{ #category : #accessing }
DeadGridCell >> isAlive [
	^ false
]
