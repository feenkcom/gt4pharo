Class {
	#name : #GtSendNotUsedCritic,
	#superclass : #GtMethodCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #testing }
GtSendNotUsedCritic class >> isAbstract [
	^ self = GtSendNotUsedCritic
]

{ #category : #private }
GtSendNotUsedCritic >> fixItActionsFor: aNode using: aCriticStyler [
	^ {GtRemoveMessageFixItAction forCoder: aCriticStyler coderModel node: aNode}
]

{ #category : #accessing }
GtSendNotUsedCritic >> matches: aNode from: aCriticRunner [
	aNode isMessage ifFalse: [ ^ false ].
	aNode isUsed ifTrue: [ ^ false ].
	^ self selectors includes: aNode selector
]

{ #category : #accessing }
GtSendNotUsedCritic >> selectors [
	self subclassResponsibility
]
