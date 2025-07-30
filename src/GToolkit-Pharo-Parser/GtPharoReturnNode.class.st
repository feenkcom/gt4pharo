Class {
	#name : #GtPharoReturnNode,
	#superclass : #GtPharoProgramNode,
	#instVars : [
		'upArrow',
		'value'
	],
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoReturnNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitReturn: self
]

{ #category : #testing }
GtPharoReturnNode >> isReturn [
	^ true
]

{ #category : #accessing }
GtPharoReturnNode >> messageReceiver [
	^ value messageReceiver
]

{ #category : #generated }
GtPharoReturnNode >> nodeVariables [
	^ #(#value)
]

{ #category : #generated }
GtPharoReturnNode >> tokenVariables [
	^ #(#upArrow)
]

{ #category : #generated }
GtPharoReturnNode >> upArrow [
	^ upArrow
]

{ #category : #generated }
GtPharoReturnNode >> upArrow: aSmaCCToken [
	upArrow := aSmaCCToken
]

{ #category : #generated }
GtPharoReturnNode >> value [
	^ value
]

{ #category : #generated }
GtPharoReturnNode >> value: aGtPharoValueNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aGtPharoValueNode.
	self value notNil ifTrue: [ self value parent: self ]
]
