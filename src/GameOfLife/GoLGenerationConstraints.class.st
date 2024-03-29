Class {
	#name : #GoLGenerationConstraints,
	#superclass : #GoLConstraint,
	#instVars : [
		'constraints'
	],
	#category : #'GameOfLife-Core'
}

{ #category : #'adding - constraint' }
GoLGenerationConstraints >> add: aConstraint [
	constraints add: aConstraint
]

{ #category : #initialization }
GoLGenerationConstraints >> initialize [
	constraints := OrderedCollection empty
]

{ #category : #'satisfy - constraints' }
GoLGenerationConstraints >> satisfy: aGenerationAsBlock2D atRow: rowNumber column: columnNumber [
	constraints ifEmpty: [ ^ true ].
	^ constraints
		allSatisfy: [ :aConstraint | 
			aConstraint
				satisfy: aGenerationAsBlock2D
				atRow: rowNumber
				column: columnNumber ]
]
