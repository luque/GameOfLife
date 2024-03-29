Class {
	#name : #OverpopulationRule,
	#superclass : #NeighborhoodConstraint,
	#category : #'GameOfLife-Rules'
}

{ #category : #initalization }
OverpopulationRule >> initialize [
	checkBlock := [ :numberAliveNeighbors :isAlive | isAlive not or: [isAlive and: [ numberAliveNeighbors <= 3 ] ] ]
]
