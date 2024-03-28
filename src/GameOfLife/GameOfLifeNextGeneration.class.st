Class {
	#name : #GameOfLifeNextGeneration,
	#superclass : #Announcement,
	#instVars : [
		'generation'
	],
	#category : #'GameOfLife-Announcements'
}

{ #category : #'instance - creation' }
GameOfLifeNextGeneration class >> generation: aNumber [
	^ self new
		generation: aNumber;
		yourself
]

{ #category : #accessing }
GameOfLifeNextGeneration >> generation [
	^ generation
]

{ #category : #accessing }
GameOfLifeNextGeneration >> generation: anObject [
	generation := anObject
]
