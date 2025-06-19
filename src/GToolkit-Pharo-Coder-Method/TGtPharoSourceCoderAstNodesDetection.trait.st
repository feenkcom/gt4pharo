Trait {
	#name : #TGtPharoSourceCoderAstNodesDetection,
	#category : #'GToolkit-Pharo-Coder-Method-Utilities'
}

{ #category : #'private - ast' }
TGtPharoSourceCoderAstNodesDetection >> detectBehaviorAt: aTextPosition ifFound: aFoundBlock ifNone: aNoneBlock [
	"Try to find a Behavior at the given source text position and evaluate a found block
	with the found Behavior as an argument if such Beahvior was found or none block otherwise. Return the result"
	<return: #Object>

	^ self
		variableNodeAt: aTextPosition
		ifFound: [ :aVariableNode |
			self
				variableNodeToBehavior: aVariableNode
				ifFound: aFoundBlock
				ifNone: aNoneBlock ]
		ifNone: aNoneBlock
]

{ #category : #'private - ast' }
TGtPharoSourceCoderAstNodesDetection >> detectBehaviorIn: aSourceString ifFound: aFoundBlock ifNone: aNoneBlock [
	"Try to find a Behavior within the given source string and evaluate a found block
	with the found Behavior as an argument if such Beahvior was found or none block otherwise. Return the result"
	<return: #Object>
	
	^ self
		variableNodeIn: aSourceString
		ifFound: [ :aVariableNode |
			self
				variableNodeToBehavior: aVariableNode
				ifFound: aFoundBlock
				ifNone: aNoneBlock ]
		ifNone: aNoneBlock
]

{ #category : #'private - ast' }
TGtPharoSourceCoderAstNodesDetection >> detectReferencesFilterAt: aTextPosition withBehavior: aTargetBehaviour ifFound: aFoundBlock ifNone: aNoneBlock [
	"Try to find a name (symbol) in the source code at a given text position of the entity that plays a role
	of the entity reference in the system and create a corresponding references filter.
	Evaluate a found block with the found reference as an argument or none block otherwise. Return the result"
	<return: #Object>
	^ self
		nodeAt: aTextPosition
		ifFound: [ :aNode |
			self
				nodeToReferencesFilter: aNode
				withBehavior: aTargetBehaviour
				ifFound: aFoundBlock
				ifNone: aNoneBlock ]
		ifNone: aNoneBlock
]

{ #category : #'private - ast' }
TGtPharoSourceCoderAstNodesDetection >> detectReferencesFilterIn: aSourceString withBehavior: aTargetBehaviour ifFound: aFoundBlock ifNone: aNoneBlock [
	"Try to find a name (symbol) in the given source string of the entity that plays a role
	of the entity reference in the system and create a corresponding references filter.
	Evaluate a found block with the found reference as an argument or none block otherwise. Return the result"
	<return: #Object>
	| aNode |

	aNode := self targetAstParserClass
		parseWithErrors: aSourceString
		startingAt: self targetAstParserClass startingStateForStatement.

	^ self
		nodeToReferencesFilter: aNode
		withBehavior: aTargetBehaviour
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'private - ast' }
TGtPharoSourceCoderAstNodesDetection >> detectSelectorAt: aTextPosition ifFound: aFoundBlock ifNone: aNoneBlock [
	"Try to find a message selector at the given source text position and evaluate a found block
	with the found selector as an argument if such selector was found or none block otherwise. Return the result"
	<return: #Object>

	^ self
		nodeAt: aTextPosition
		ifFound: [ :aNode |
			self
				nodeToSelector: aNode
				ifFound: [ :aSelector | aFoundBlock cull: aSelector cull: aNode ]
				ifNone: aNoneBlock ]
		ifNone: aNoneBlock
]

{ #category : #'private - ast' }
TGtPharoSourceCoderAstNodesDetection >> detectSelectorIn: aSourceString ifFound: aFoundBlock ifNone: aNoneBlock [
	"Try to find a message selector in the given source string and evaluate a found block
	with the found selector as an argument if such selector was found or none block otherwise. Return the result"
	<return: #Object>
	| aNode |

	aNode := self targetAstParserClass 
		parseWithErrors: aSourceString
		startingAt: self targetAstParserClass startingStateForStatement.

	^ self
		nodeToSelector: aNode
		ifFound: [ :aSelector | aFoundBlock cull: aSelector cull: aNode ]
		ifNone: aNoneBlock
]

{ #category : #'private - ast' }
TGtPharoSourceCoderAstNodesDetection >> nodeToReferencesFilter: aNode withBehavior: aTargetBehaviour ifFound: aFoundBlock ifNone: aNoneBlock [
	"Try to create a references filter from a given AST node. If aNode is not suitable
	for creating a filter, also check all parents of that node. Evaluate aFoundBlock if a references filter
	was built and aNoneBlock otherwise, return the result of the block evaluation"
	<return: #Object>
	| aCurrentNode |

	aCurrentNode := aNode.

	[ aCurrentNode notNil ] whileTrue: [
		(aCurrentNode isKindOf: GtPharoVariableNode)
			ifTrue: [
				^ self
					variableNodeToReferencesFilter: aCurrentNode
					withBehavior: aTargetBehaviour
					ifFound: aFoundBlock
					ifNone: aNoneBlock ].
		(aCurrentNode isKindOf: GtPharoPragmaNode)
			ifTrue: [ ^ aFoundBlock cull: (self referencesFilterForPragma: aCurrentNode selector) cull: aCurrentNode ].
		(aCurrentNode isKindOf: GtPharoSymbolLiteralNode)
			ifTrue: [ ^ aFoundBlock cull: (self referencesFilterForLiteral: aCurrentNode asSymbol) cull: aCurrentNode ].
		(aCurrentNode isKindOf: GtPharoStringLiteralNode)
			ifTrue: [ ^ aFoundBlock cull: (self referencesFilterForString: aCurrentNode value value) cull: aCurrentNode ].
		(aCurrentNode isKindOf: GtPharoCharacterLiteralNode)
			ifTrue: [ ^ aFoundBlock cull: (self referencesFilterForCharacter: aCurrentNode value value) cull: aCurrentNode ].
		(aCurrentNode isKindOf: GtPharoBooleanLiteralNode)
			ifTrue: [ ^ aFoundBlock cull: (self referencesFilterForBoolean: aCurrentNode value value) cull: aCurrentNode ].
		(aCurrentNode isKindOf: GtPharoNumberLiteralNode)
			ifTrue: [ ^ aFoundBlock cull: (self referencesFilterForNumber: aCurrentNode value value) cull: aCurrentNode ].
		((aCurrentNode isKindOf: GtPharoMessageNode)
			or: [ aCurrentNode isKindOf: GtPharoMethodPatternNode ])
			ifTrue: [ ^ aFoundBlock cull: (self referencesFilterForLiteral: aCurrentNode selector) cull: aCurrentNode ].
		(aCurrentNode isKindOf: GtPharoMessageSendNode)
			ifTrue: [ aCurrentNode := aCurrentNode message ]
			ifFalse: [ aCurrentNode := aCurrentNode parent ] ].

	^ aNoneBlock value
]

{ #category : #'private - ast' }
TGtPharoSourceCoderAstNodesDetection >> nodeToSelector: aNode ifFound: aFoundBlock ifNone: aNoneBlock [
	"Try to extract a message selector from a given AST node. If aNode is not suitable
	for extracting a selector, also check all parents of that node. Evaluate aFoundBlock if a selector
	is found and aNoneBlock otherwise, return the result of the block evaluation"
	<return: #Object>
	| aCurrentNode |

	aCurrentNode := aNode.
	[ aCurrentNode notNil ]
		whileTrue: [
			(aCurrentNode isKindOf: GtPharoVariableNode)
				ifTrue: [ ^ aFoundBlock value: aCurrentNode name source asSymbol ].
			(aCurrentNode isKindOf: GtPharoSymbolLiteralNode)
				ifTrue: [ ^ aFoundBlock value: aNode asSymbol ].
			(aCurrentNode isKindOf: GtPharoMessageSendNode)
				ifTrue: [ aCurrentNode := aCurrentNode message ].
			((aCurrentNode isKindOf: GtPharoMessageNode)
				or: [ aCurrentNode isKindOf: GtPharoMethodPatternNode ])
				ifTrue: [ ^ aFoundBlock value: aCurrentNode selector ].
			aCurrentNode := aCurrentNode parent ].
	^ aNoneBlock value
]

{ #category : #'private - ast' }
TGtPharoSourceCoderAstNodesDetection >> referencesFilterForBoolean: aBooleanAsString [
	"aBooleanAsString would be a string 'true', which should be evaluated to get a boolean"

	^ self referencesFilterForLiteral: (Smalltalk compiler evaluate: aBooleanAsString)
]

{ #category : #'private - ast' }
TGtPharoSourceCoderAstNodesDetection >> referencesFilterForCharacter: aCharacterAsString [
	"aCharacterAsString would be a string '$a', which should be evaluated to get a character"

	^ self referencesFilterForLiteral: (Smalltalk compiler evaluate: aCharacterAsString)
]

{ #category : #'private - ast' }
TGtPharoSourceCoderAstNodesDetection >> referencesFilterForLiteral: anObject [
	^ GtSearchReferencesFilter literal: anObject
]

{ #category : #'private - ast' }
TGtPharoSourceCoderAstNodesDetection >> referencesFilterForNumber: aNumberAsString [
	"aNumberAsString would be a string '42', which should be evaluated to get a boolean"

	^ self referencesFilterForLiteral: (Smalltalk compiler evaluate: aNumberAsString)
]

{ #category : #'private - ast' }
TGtPharoSourceCoderAstNodesDetection >> referencesFilterForPragma: aSymbol [
	^ GtSearchPragmasFilter forPragma: aSymbol 
]

{ #category : #'private - ast' }
TGtPharoSourceCoderAstNodesDetection >> referencesFilterForString: aString [
	"we have to dispatch through the compiler and to evaluate: the string, otherwise it will not be searched for
	because it is compared by identity and compiler does some string optimizations"

	^ self referencesFilterForLiteral: (Smalltalk compiler evaluate: aString)
]

{ #category : #'private - ast' }
TGtPharoSourceCoderAstNodesDetection >> referencesFilterForSymbol: aSymbol [
	^ self referencesFilterForLiteral: aSymbol
]

{ #category : #accessing }
TGtPharoSourceCoderAstNodesDetection >> targetAstParserClass [
	^ self explicitRequirement
]

{ #category : #'private - ast' }
TGtPharoSourceCoderAstNodesDetection >> variableNodeAt: aTextPosition ifFound: aFoundBlock ifNone: aNoneBlock [
	"Try to find a variable node ${class:GtPharoVariableNode}$ at a given text position and evaluate a found
	block if such node exists and none block otherwise. Return the result"
	<return: #Object>
	[
		| theAST |
		theAST := self astSync.
		theAST
			withAllNodesOfType: GtPharoVariableNode
			do: [ :node | 
				(aTextPosition between: node startPosition - 1 and: node stopPosition)
					ifTrue: [ ^ aFoundBlock value: node ] ] ]
		on: Error
		do: [ :ex | ex return ].

	^ aNoneBlock value
]

{ #category : #'private - ast' }
TGtPharoSourceCoderAstNodesDetection >> variableNodeIn: aSourceString ifFound: aFoundBlock ifNone: aNoneBlock [
	"Try to extract a variable node ${class:GtPharoVariableNode}$ in a given string and evaluate a found block
	if such node was found and a none block otherwise. Return the result."
	<return: #Object>
	| eachNode |

	eachNode := self targetAstParserClass 
		parseWithErrors: aSourceString
		startingAt: self targetAstParserClass startingStateForStatement.

	[ eachNode isNil ]
		whileFalse: [ 
			(eachNode isKindOf: GtPharoVariableNode)
				ifTrue: [ ^ aFoundBlock value: eachNode ].
			eachNode := eachNode parent ].

	^ aNoneBlock value
]

{ #category : #'private - ast' }
TGtPharoSourceCoderAstNodesDetection >> variableNodeToBehavior: aVariableNode ifFound: aFoundBlock ifNone: aNoneBlock [
	"Convert a given variable node to a behavior registered in the system and evaluate
	a found block if such behavior exists, evaluate none block otherwise. Return the result"
	<return: #Object>
	| aVariableName aBehavior |

	aVariableName := aVariableNode name value asSymbol.

	aBehavior := self class environment
		at: aVariableName
		ifAbsent: [ ^ aNoneBlock value ].

	aBehavior isBehavior
		ifFalse: [ ^ aNoneBlock value ].

	^ aFoundBlock value: aBehavior
]

{ #category : #'private - ast' }
TGtPharoSourceCoderAstNodesDetection >> variableNodeToReferencesFilter: aVariableNode withBehavior: aTargetBehaviour ifFound: aFoundBlock ifNone: aNoneBlock [
	"Convert a given variable node to the references filter and evaluate
	a found block if such filter can be created, evaluate none block otherwise. Return the result"
	<return: #Object>
	| aVariableName aVariableIndex aDefiningClass aBinding |
	
	aVariableName := aVariableNode name source.
	aVariableIndex := aTargetBehaviour instVarIndexFor: aVariableName.
	aVariableIndex > 0
		ifTrue: [
			aDefiningClass := aTargetBehaviour whichClassDefinesInstVar: aVariableName.
			^ aFoundBlock 
				cull: (GtSearchInstanceSlotReferenceFilter
					forClassAndSubclasses: aDefiningClass
					andVariable: aVariableName)
				 cull: aVariableNode ].

	aBinding := aTargetBehaviour bindingOf: aVariableName.
	aBinding notNil
		ifTrue: [ ^ aFoundBlock 
			cull: (GtSearchReferencesFilter literal: aBinding) 
			cull: aVariableNode ].
		
	"At this point we know that it is not an instance/class variable, nor it is a binding.
	We therefore fallback to the basic literal references filter"

	^ aFoundBlock 
		cull: (self referencesFilterForLiteral: aVariableName asSymbol)
		cull: aVariableNode
]
