Class {
	#name : #GtSmalltalkSourceCoder,
	#superclass : #GtSourceCoder,
	#traits : 'TGtPharoSourceCoderAstNodesDetection',
	#classTraits : 'TGtPharoSourceCoderAstNodesDetection classTrait',
	#classVars : [
		'NodeHighlight'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Coder'
}

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
