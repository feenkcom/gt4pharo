Class {
	#name : 'GtPharoUnaryMessageNode',
	#superclass : 'GtPharoMessageNode',
	#instVars : [
		'selectorPart'
	],
	#category : 'GToolkit-Pharo-Parser-Parser'
}

{ #category : 'generated' }
GtPharoUnaryMessageNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitUnaryMessage: self
]

{ #category : 'accessing' }
GtPharoUnaryMessageNode >> arguments [
	^ #()
]

{ #category : 'testing' }
GtPharoUnaryMessageNode >> isUnary [
	^ true
]

{ #category : 'accessing' }
GtPharoUnaryMessageNode >> messageReceiver [
	^ parent
]

{ #category : 'generated' }
GtPharoUnaryMessageNode >> nodeVariables [
	^ #(#selectorPart)
]

{ #category : 'accessing' }
GtPharoUnaryMessageNode >> selector [
	^ self selectorPart value asSymbol
]

{ #category : 'generated' }
GtPharoUnaryMessageNode >> selectorPart [
	^ selectorPart
]

{ #category : 'generated' }
GtPharoUnaryMessageNode >> selectorPart: aGtPharoNameNode [
	self selectorPart notNil
		ifTrue: [ self selectorPart parent: nil ].
	selectorPart := aGtPharoNameNode.
	self selectorPart notNil
		ifTrue: [ self selectorPart parent: self ]
]

{ #category : 'accessing' }
GtPharoUnaryMessageNode >> selectorParts [
	^ {selectorPart}
]
