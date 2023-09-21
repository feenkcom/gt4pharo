Class {
	#name : #GtPharoDoItMethodNode,
	#superclass : #GtPharoProgramNode,
	#instVars : [
		'body'
	],
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoDoItMethodNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitDoItMethod: self
]

{ #category : #generated }
GtPharoDoItMethodNode >> body [
	^ body
]

{ #category : #generated }
GtPharoDoItMethodNode >> body: aGtPharoSequenceNode [
	self body notNil ifTrue: [ self body parent: nil ].
	body := aGtPharoSequenceNode.
	self body notNil ifTrue: [ self body parent: self ]
]

{ #category : #testing }
GtPharoDoItMethodNode >> isMethod [
	^ true
]

{ #category : #generated }
GtPharoDoItMethodNode >> nodeVariables [
	^ #(#body)
]
