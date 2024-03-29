Class {
	#name : #GoLGameOfLifeNextGeneration,
	#superclass : #Announcement,
	#instVars : [
		'generation'
	],
	#category : #'GameOfLife-Announcements'
}

{ #category : #'instance - creation' }
GoLGameOfLifeNextGeneration class >> generation: aNumber [
	^ self new
		generation: aNumber;
		yourself
]

{ #category : #accessing }
GoLGameOfLifeNextGeneration >> generation [
	^ generation
]

{ #category : #accessing }
GoLGameOfLifeNextGeneration >> generation: anObject [
	generation := anObject
]
