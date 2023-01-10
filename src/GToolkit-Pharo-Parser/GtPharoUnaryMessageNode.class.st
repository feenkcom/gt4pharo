Class {
	#name : #GtPharoUnaryMessageNode,
	#superclass : #GtPharoMessageNode,
	#instVars : [
		'selectorPart'
	],
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #accessing }
GtPharoUnaryMessageNode class >> priority [
	^ 1
]

{ #category : #generated }
GtPharoUnaryMessageNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitUnaryMessage: self
]

{ #category : #accessing }
GtPharoUnaryMessageNode >> arguments [
	^ #()
]

{ #category : #testing }
GtPharoUnaryMessageNode >> isConstructorMessage [
	^ self selectorPart source = 'new'
]

{ #category : #testing }
GtPharoUnaryMessageNode >> isUnary [
	^ true
]

{ #category : #accessing }
GtPharoUnaryMessageNode >> messageReceiver [
	^ parent
]

{ #category : #accessing }
GtPharoUnaryMessageNode >> selector [
	^ self selectorPart value asSymbol
]

{ #category : #generated }
GtPharoUnaryMessageNode >> selectorPart [
	^ selectorPart
]

{ #category : #generated }
GtPharoUnaryMessageNode >> selectorPart: aSmaCCToken [
	selectorPart := aSmaCCToken
]

{ #category : #accessing }
GtPharoUnaryMessageNode >> selectorParts [
	^ {selectorPart}
]

{ #category : #generated }
GtPharoUnaryMessageNode >> tokenVariables [
	^ #(#selectorPart)
]
