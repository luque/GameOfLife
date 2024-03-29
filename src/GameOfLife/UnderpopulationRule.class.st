Class {
	#name : #UnderpopulationRule,
	#superclass : #NeighborhoodConstraint,
	#category : #'GameOfLife-Rules'
}

{ #category : #initialization }
UnderpopulationRule >> initialize [
	checkBlock := [ :numberOfAliveNeighbors :isAlive | isAlive not or: [ isAlive and: [ numberOfAliveNeighbors >= 2 ] ] ]
]
