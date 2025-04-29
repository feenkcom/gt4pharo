Class {
	#name : #GtSmalltalkSourceCoder,
	#superclass : #GtSourceCoder,
	#traits : 'TGtPharoSourceCoderAstNodesDetection',
	#classTraits : 'TGtPharoSourceCoderAstNodesDetection classTrait',
	#classVars : [
		'DoubleClickClassifier',
		'NodeHighlight',
		'WordMovementClassifier'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Coder'
}

{ #category : #accessing }
GtSmalltalkSourceCoder class >> doubleClickClassifier [
	^ DoubleClickClassifier
]

{ #category : #accessing }
GtSmalltalkSourceCoder class >> doubleClickClassifier: anObject [
	DoubleClickClassifier := anObject
]

{ #category : #initialization }
GtSmalltalkSourceCoder class >> initialize [
	WordMovementClassifier := self smalltalkWordClassifier.
	DoubleClickClassifier := self smalltalkWordClassifier
]

{ #category : #private }
GtSmalltalkSourceCoder class >> smalltalkWordClassifier [
	^ [ :c1 :c2 | 
	c1 isSeparator ~= c2 isSeparator
		or: [ ((c1 isAlphaNumeric | (c1 = $_)) not and: [ c2 isAlphaNumeric | (c2 = $_) ])
				or: [ c1 isAlphaNumeric | (c1 = $_) and: [ c2 tokenish not ] ] ] ]
]

{ #category : #accessing }
GtSmalltalkSourceCoder class >> wordMovementClassifier [
	^ WordMovementClassifier
]

{ #category : #accessing }
GtSmalltalkSourceCoder class >> wordMovementClassifier: anObject [
	WordMovementClassifier := anObject
]

{ #category : #'private - ast' }
GtSmalltalkSourceCoder >> cascadedMessagesWithin: anInterval [
	"Return a collection of cascaded messages nodes that intersect a given interval"

	<return: #Collection of: #GtPharoProgramNode>
	^ self
		nodeWithin: anInterval
		ifFound: [ :aNode | 
			aNode cascadeNode notNil
				ifTrue: [ aNode cascadeNode messages
						select: [ :eachNode | eachNode intersectsInterval: anInterval ] ]
				ifFalse: [ #() ] ]
		ifNone: [ #() ]
]
