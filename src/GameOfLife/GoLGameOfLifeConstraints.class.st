Class {
	#name : #GoLGameOfLifeConstraints,
	#superclass : #GoLGameOfLife,
	#instVars : [
		'constraints'
	],
	#category : #'GameOfLife-Core'
}

{ #category : #rules }
GoLGameOfLifeConstraints class >> classicRules [
	| rules |
	rules := GoLGenerationConstraints new.
	rules add: GoLReproductionRule new.
	rules add: GoLOverpopulationRule new.
	rules add: GoLUnderpopulationRule new.
	^ rules
]

{ #category : #example }
GoLGameOfLifeConstraints class >> emptyGame [
	| game |
	game := self withClassicRules.
	game initializeWithRows: 10
		columns: 10
		ofSize: 5 @ 5.
	^ game
]

{ #category : #'instance - creation' }
GoLGameOfLifeConstraints class >> withClassicRules [
	^ self new add: self classicRules; yourself
]

{ #category : #'add - constraints' }
GoLGameOfLifeConstraints >> add: aConstraint [
	constraints add: aConstraint
]

{ #category : #generations }
GoLGameOfLifeConstraints >> getNextGenerationFor: row column: column [
	"Verifies the Game Of Life constraints"

	| alternativeStateGeneration alternativeState currentState |
	currentState := currentGeneration at: row at: column.
	(constraints
		satisfy: currentGeneration
		atRow: row
		column: column)
		ifTrue: [ ^ currentState ]
		ifFalse: [ alternativeState := currentState = 1 ifTrue: [ 0 ] ifFalse: [ 1 ].
			alternativeStateGeneration := currentGeneration copy
					at: row
					at: column
					put: alternativeState;
					yourself.
			(constraints
				satisfy: alternativeStateGeneration
				atRow: row
				column: column)
				ifTrue: [ ^ alternativeState ]
				ifFalse: [ GoLConstraintsNotSatisfiable signal ] ]
]

{ #category : #initalization }
GoLGameOfLifeConstraints >> initialize [
	super initialize.
	constraints := GoLGenerationConstraints new.
]
