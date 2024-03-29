Class {
	#name : #GoLConstraint,
	#superclass : #Object,
	#category : #'GameOfLife-Core'
}

{ #category : #'satisfy - constraints' }
GoLConstraint >> satisfy: aGenerationAsBlock2D atRow: rowNumber column: columnNumber [
	self subclassResponsibility
]
