Class {
	#name : #ReproductionRule,
	#superclass : #NeighborhoodConstraint,
	#category : #'GameOfLife-Rules'
}

{ #category : #initalization }
ReproductionRule >> initialize [
	checkBlock := [ :numberOfAliveNeighbors :isAlive | isAlive or: [ isAlive not and: [ (numberOfAliveNeighbors = 3) not ] ] ]
]
