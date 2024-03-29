Class {
	#name : #GoLNeighborhoodConstraint,
	#superclass : #GoLGenerationConstraint,
	#category : #'GameOfLife-Core'
}

{ #category : #'satisfy - constraints' }
GoLNeighborhoodConstraint >> satisfy: aGenerationAsBlock2D atRow: rowNumber column: columnNumber [
	| numberAliveNeighbors isAliveCell |
	numberAliveNeighbors := aGenerationAsBlock2D numberAliveNeighborsAtRow: rowNumber column: columnNumber.
	isAliveCell := aGenerationAsBlock2D isAliveAtRow: rowNumber column: columnNumber.
	^ checkBlock value: numberAliveNeighbors value: isAliveCell
]
