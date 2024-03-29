Class {
	#name : #GenerationConstraints,
	#superclass : #Constraint,
	#instVars : [
		'constraints'
	],
	#category : #'GameOfLife-Core'
}

{ #category : #'adding - constraint' }
GenerationConstraints >> add: aConstraint [
	constraints add: aConstraint
]

{ #category : #initialization }
GenerationConstraints >> initialize [
	constraints := OrderedCollection empty
]

{ #category : #'satisfy - constraints' }
GenerationConstraints >> satisfy: aGenerationAsBlock2D atRow: rowNumber column: columnNumber [
	constraints ifEmpty: [ ^ true ].
	^ constraints
		allSatisfy: [ :aConstraint | 
			aConstraint
				satisfy: aGenerationAsBlock2D
				atRow: rowNumber
				column: columnNumber ]
]
