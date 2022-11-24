Class {
	#name : #GtConvertCascadesToStatementsRefactoring,
	#superclass : #RBMethodRefactoring,
	#instVars : [
		'sourceInterval',
		'selector'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #'instance creation' }
GtConvertCascadesToStatementsRefactoring class >> model: model convert: anInterval inMethod: aSelector forClass: aClass [
	^ self new
		model: model;
		convert: anInterval
			inMethod: aSelector
			forClass: aClass;
		yourself
]

{ #category : #initialization }
GtConvertCascadesToStatementsRefactoring >> convert: anInterval inMethod: aSelector forClass: aClassOrSymbol [
	sourceInterval := anInterval.
	selector := aSelector.
	class := self model classObjectFor: aClassOrSymbol
]

{ #category : #accessing }
GtConvertCascadesToStatementsRefactoring >> extractReceiverIntoVariable: aNode [
	| statement newAssignment oldReceiver variable |
	(aNode parent isAssignment and: [ aNode messages last selector = #yourself ])
		ifTrue: [ statement := self findStatement: aNode.
			newAssignment := RBAssignmentNode
					variable: aNode parent variable copy
					value: aNode receiver copy.
			oldReceiver := aNode receiver.
			aNode messages
				do: [ :each | each replaceNode: oldReceiver withNode: newAssignment ].
			aNode parent parent replaceNode: aNode parent withNode: aNode ].
	aNode receiver isAssignment
		ifTrue: [ statement := self findStatement: aNode.
			statement parent addNode: aNode receiver copy before: statement.
			variable := aNode receiver variable.
			aNode messages
				do: [ :each | each replaceNode: aNode receiver withNode: variable ].
			^ aNode ].
	^ self extractTempForReceiver: aNode
]

{ #category : #accessing }
GtConvertCascadesToStatementsRefactoring >> extractStatementsFor: aNode [
	| statement newMessages |
	newMessages := aNode messages collect: [ :each | each copy ].
	(newMessages last isMessage and: [ newMessages last selector = #yourself ])
		ifTrue: [ newMessages at: newMessages size put: newMessages last receiver ].
	statement := self findStatement: aNode.
	statement parent addNodes: newMessages allButLast before: statement.
	(statement == aNode and: [ newMessages last isVariable ])
		ifTrue: [ aNode parent removeNode: aNode ]
		ifFalse: [ aNode parent replaceNode: aNode withNode: newMessages last ].
	class compileTree: aNode methodNode
]

{ #category : #accessing }
GtConvertCascadesToStatementsRefactoring >> extractTempForReceiver: aNode [
	| tempName sourceTree |
	tempName := (self options at: #receiverName) value: self.
	self
		performCompositeRefactoring: (RBExtractToTemporaryRefactoring
				model: self model
				extract: aNode receiver sourceInterval
				to: tempName
				from: selector
				in: class).
	sourceTree := class parseTreeFor: selector.
	sourceTree
		nodesDo: [ :each | 
			(each isCascade
				and: [ each receiver isVariable
						and: [ each receiver name = tempName
								and: [ each messages size = aNode messages size ] ] ])
				ifTrue: [ ^ each ] ].
	self
		refactoringError: 'Could not find cascaded after extracting temporary variable'
]

{ #category : #accessing }
GtConvertCascadesToStatementsRefactoring >> findNode [
	| sourceTree |
	sourceTree := class parseTreeFor: selector.
	sourceTree ifNil: [ self refactoringFailure: 'Could not parse source' ].
	sourceTree
		nodesDo: [ :each | 
			(each isCascade and: [ each sourceInterval = sourceInterval ])
				ifTrue: [ ^ each ] ].
	^ nil
]

{ #category : #accessing }
GtConvertCascadesToStatementsRefactoring >> findStatement: aNode [
	| current |
	current := aNode.
	[ current parent isSequence ] whileFalse: [ current := current parent ].
	^ current
]

{ #category : #accessing }
GtConvertCascadesToStatementsRefactoring >> preconditions [
	^ RBCondition definesSelector: selector in: class
]

{ #category : #accessing }
GtConvertCascadesToStatementsRefactoring >> transform [
	| node |
	node := self findNode.
	node isCascade
		ifFalse: [ ^ self refactoringError: 'Node is not a cascade message send' ].
	node receiver isVariable
		ifFalse: [ node := self extractReceiverIntoVariable: node ].
	self extractStatementsFor: node
]
