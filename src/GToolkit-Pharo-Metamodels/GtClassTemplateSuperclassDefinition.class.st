Class {
	#name : #GtClassTemplateSuperclassDefinition,
	#superclass : #GtClassSuperclassDefinition,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Definitions'
}

{ #category : #accessing }
GtClassTemplateSuperclassDefinition >> name: aSymbol [
	| anOldName |
	
	anOldName := name.
	name := aSymbol.
	
	anOldName = name
		ifTrue: [ ^ self ].
	
	self
		notifySuperclassRenamed: self
		from: anOldName
		to: name
]
