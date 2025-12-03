Class {
	#name : #GtRemoveMessageFixItAction,
	#superclass : #GtRemoveValueFixItAction,
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices-FixIt'
}

{ #category : #examples }
GtRemoveMessageFixItAction class >> removeCollect [
	<gtExample>
	^ self
		testOriginal: 'a (1 to: 10) collect: [:i | Transcript print: i; cr]. ^#()'
		generates: 'a ^#()'
		forNode: [ :method | method body statements first message ]
]

{ #category : #examples }
GtRemoveMessageFixItAction class >> removeFromMiddleOfCascade [
	<gtExample>
	^ self
		testOriginal: 'a Transcript print: 1; yourself; print: 2'
		generates: 'a Transcript print: 1; print: 2'
		forNode: [ :method | method body statements first messages second ]
]

{ #category : #examples }
GtRemoveMessageFixItAction class >> removeYourself [
	<gtExample>
	^ self
		testOriginal: 'a Transcript print: 1; print: 2; yourself'
		generates: 'a Transcript print: 1; print: 2'
		forNode: [ :method | method body statements first messages last ]
]

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
