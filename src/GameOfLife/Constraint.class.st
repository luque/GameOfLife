Class {
	#name : #Constraint,
	#superclass : #Object,
	#category : #'GameOfLife-Core'
}

{ #category : #'satisfy - constraints' }
Constraint >> satisfy: aGenerationAsBlock2D atRow: rowNumber column: columnNumber [
	self subclassResponsibility
]
