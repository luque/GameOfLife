Class {
	#name : #GoLUnderpopulationRule,
	#superclass : #GoLNeighborhoodConstraint,
	#category : #'GameOfLife-Rules'
}

{ #category : #initialization }
GoLUnderpopulationRule >> initialize [
	checkBlock := [ :numberOfAliveNeighbors :isAlive | isAlive not or: [ isAlive and: [ numberOfAliveNeighbors >= 2 ] ] ]
]
