Class {
	#name : #GameOfLifeConstraints,
	#superclass : #GameOfLife,
	#instVars : [
		'constraints'
	],
	#category : #'GameOfLife-Core'
}

{ #category : #rules }
GameOfLifeConstraints class >> classicRules [
	| rules |
	rules := GenerationConstraints new.
	rules add: ReproductionRule new.
	rules add: OverpopulationRule new.
	rules add: UnderpopulationRule new.
	^ rules
]

{ #category : #example }
GameOfLifeConstraints class >> emptyGame [
	| game |
	game := self withClassicRules.
	game initializeWithRows: 10
		columns: 10
		ofSize: 5 @ 5.
	^ game
]

{ #category : #'instance - creation' }
GameOfLifeConstraints class >> withClassicRules [
	^ self new add: self classicRules; yourself
]

{ #category : #'add - constraints' }
GameOfLifeConstraints >> add: aConstraint [
	constraints add: aConstraint
]

{ #category : #generations }
GameOfLifeConstraints >> getNextGenerationFor: row column: column [
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
				ifFalse: [ ConstraintsNotSatisfiable signal ] ]
]

{ #category : #initalization }
GameOfLifeConstraints >> initialize [
	super initialize.
	constraints := GenerationConstraints new.
]
