Class {
	#name : #GtPharoBinaryMessageNode,
	#superclass : #GtPharoMessageNode,
	#instVars : [
		'selectorPart',
		'value'
	],
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #accessing }
GtPharoBinaryMessageNode class >> priority [
	^ 2
]

{ #category : #generated }
GtPharoBinaryMessageNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitBinaryMessage: self
]

{ #category : #accessing }
GtPharoBinaryMessageNode >> arguments [
	^ { self value }
]

{ #category : #testing }
GtPharoBinaryMessageNode >> isBinary [
	^ true
]

{ #category : #accessing }
GtPharoBinaryMessageNode >> messageReceiver [
	^ value messageReceiver
]

{ #category : #generated }
GtPharoBinaryMessageNode >> nodeVariables [
	^ #(#value)
]

{ #category : #accessing }
GtPharoBinaryMessageNode >> selector [
	^ self selectorPart value asSymbol
]

{ #category : #generated }
GtPharoBinaryMessageNode >> selectorPart [
	^ selectorPart
]

{ #category : #generated }
GtPharoBinaryMessageNode >> selectorPart: aSmaCCToken [
	selectorPart := aSmaCCToken
]

{ #category : #accessing }
GtPharoBinaryMessageNode >> selectorParts [
	^ {selectorPart}
]

{ #category : #generated }
GtPharoBinaryMessageNode >> tokenVariables [
	^ #(#selectorPart)
]

{ #category : #generated }
GtPharoBinaryMessageNode >> value [
	^ value
]

{ #category : #generated }
GtPharoBinaryMessageNode >> value: aGtPharoValueNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aGtPharoValueNode.
	self value notNil ifTrue: [ self value parent: self ]
]
