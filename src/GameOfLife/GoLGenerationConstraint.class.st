Class {
	#name : #GoLGenerationConstraint,
	#superclass : #GoLConstraint,
	#instVars : [
		'checkBlock'
	],
	#category : #'GameOfLife-Core'
}

{ #category : #'instance - creation' }
GoLGenerationConstraint class >> fromBlock: aBlock [
	^ self new
		checkblock: aBlock;
		yourself
]

{ #category : #accessing }
GoLGenerationConstraint >> checkBlock: anObject [
	checkBlock := anObject
]

{ #category : #accessing }
GoLGenerationConstraint >> satisfy: aGenerationAsBlock2D atRow: rowNumber column: columnNumber [
	^ checkBlock
		value: aGenerationAsBlock2D
		value: rowNumber
		value: columnNumber
]
