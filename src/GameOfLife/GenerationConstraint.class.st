Class {
	#name : #GenerationConstraint,
	#superclass : #Constraint,
	#instVars : [
		'checkBlock'
	],
	#category : #'GameOfLife-Core'
}

{ #category : #'instance - creation' }
GenerationConstraint class >> fromBlock: aBlock [
	^ self new
		checkblock: aBlock;
		yourself
]

{ #category : #accessing }
GenerationConstraint >> checkBlock: anObject [
	checkBlock := anObject
]

{ #category : #accessing }
GenerationConstraint >> satisfy: aGenerationAsBlock2D atRow: rowNumber column: columnNumber [
	^ checkBlock
		value: aGenerationAsBlock2D
		value: rowNumber
		value: columnNumber
]
