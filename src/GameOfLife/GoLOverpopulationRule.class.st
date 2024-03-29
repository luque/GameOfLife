Class {
	#name : #GoLOverpopulationRule,
	#superclass : #GoLNeighborhoodConstraint,
	#category : #'GameOfLife-Rules'
}

{ #category : #initalization }
GoLOverpopulationRule >> initialize [
	checkBlock := [ :numberAliveNeighbors :isAlive | isAlive not or: [isAlive and: [ numberAliveNeighbors <= 3 ] ] ]
]
