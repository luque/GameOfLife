Class {
	#name : #BaselineOfGameOfLife,
	#superclass : #BaselineOf,
	#category : #BaselineOfGameOfLife
}

{ #category : #baseline }
BaselineOfGameOfLife >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'GameOfLife'
		]
]
