Class {
	#name : #GtRBClassWithTrait,
	#superclass : #RBClass,
	#instVars : [
		'traitExpression'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Support'
}

{ #category : #converting }
GtRBClassWithTrait >> asClassWithTrait [
	^ self
]

{ #category : #accessing }
GtRBClassWithTrait >> traitExpression [
	^ traitExpression ifNil: [ traitExpression := super traitExpression ]
]

{ #category : #accessing }
GtRBClassWithTrait >> traitExpression: aString [
	traitExpression := aString
]
