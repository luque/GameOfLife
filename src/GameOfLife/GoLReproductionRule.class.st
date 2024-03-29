Class {
	#name : #GoLReproductionRule,
	#superclass : #GoLNeighborhoodConstraint,
	#category : #'GameOfLife-Rules'
}

{ #category : #initalization }
GoLReproductionRule >> initialize [
	checkBlock := [ :numberOfAliveNeighbors :isAlive | isAlive or: [ isAlive not and: [ (numberOfAliveNeighbors = 3) not ] ] ]
]
