Class {
	#name : #GtRemoveMessageFixItAction,
	#superclass : #GtRemoveValueFixItAction,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics-FixIt'
}

{ #category : #'api - node' }
GtRemoveMessageFixItAction >> attributePosition [
	^ node selectorParts last stopPosition
]

{ #category : #'api - action' }
GtRemoveMessageFixItAction >> description [
	^ 'Remove message send #' , node selector
]

{ #category : #'api - action' }
GtRemoveMessageFixItAction >> id [
	^ GtRemoveMessageFixItActionElementId
]

{ #category : #executing }
GtRemoveMessageFixItAction >> nodeToRemove [
	^ node parent
]

{ #category : #private }
GtRemoveMessageFixItAction >> updateSource [
	| string parent semicolonToDelete |
	parent := node parent.
	parent isMessageSend ifTrue: [ ^ super updateSource ].
	string := SmaCCString on: node topParent completeSource.
	string deleteFrom: node startPosition to: node stopPosition.
	semicolonToDelete := node == parent messages last
			ifTrue: [ parent semicolons last ]
			ifFalse: [ parent semicolons at: (parent messages identityIndexOf: node) ].
	string
		deleteFrom: semicolonToDelete startPosition
		to: semicolonToDelete stopPosition.
	self deleteStartOfLineWhitespace: string before: node.
	^ string asString
]
