Class {
	#name : #GtPharoSourceCoderPromised,
	#superclass : #GtSourceCoderPromised,
	#category : #'GToolkit-Pharo-Coder-Promised'
}

{ #category : #'private - actions' }
GtPharoSourceCoderPromised class >> debug: aCompiledMethod receiver: anObject in: evalContext [
	| guineaPig suspendedContext debugSession |

	guineaPig := [ aCompiledMethod
		valueWithReceiver: anObject
		arguments: (evalContext ifNil: [ #() ] ifNotNil: [ {evalContext} ]) ]
		newProcess.
	suspendedContext := guineaPig suspendedContext.
	
	debugSession := guineaPig newDebugSessionNamed: 'debug it' startedAt: suspendedContext.
	debugSession stepIntoUntil: [:currentContext | 
		currentContext method == aCompiledMethod ].
	
	Smalltalk tools debugger
		openOn: debugSession
		withFullView: true
]

{ #category : #constants }
GtPharoSourceCoderPromised class >> sourceEditorName [
	^ #editor
]

{ #category : #'api - accessing' }
GtPharoSourceCoderPromised >> behavior [
	"Return an optional Behavior in context of which this coder operates.
	Behavior (class, metaclass or trait) helps various add-ons and styler to provide users with better
	contextual information"
	<return: #Behavior>
	
	^ UndefinedObject
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> browseBehaviorAt: aTextPosition [
	"Try to find a behavior reference at a given source text position and request to browse it"

	self
		detectBehaviorAt: aTextPosition
		ifFound: [ :aBehavior |
			self
				notifyToolSpawn: (GtClassCoderTool observedClass: aBehavior)
				withDestination: self spawnDestination  ]
		ifNone: [  ]
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> browseBehaviorIn: aSourceString [
	"Try to find a behavior reference within a given source code and request to browse it"

	self
		detectBehaviorIn: aSourceString
		ifFound: [ :aBehavior |
			self
				notifyToolSpawn: (GtClassCoderTool observedClass: aBehavior)
				withDestination: self spawnDestination  ]
		ifNone: [  ]
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> browseImplementorsAt: aTextPosition [
	"Try to find a message selector at a given source text position and request to browse it"

	self
		detectSelectorAt: aTextPosition
		ifFound: [ :aSelector | self notifyObjectSpawn: (GtSearchImplementorsFilter selector: aSelector)  ]
		ifNone: [  ]
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> browseImplementorsIn: aSourceString [
	"Try to find a message selector within a given source string and request to browse it"

	self
		detectSelectorIn: aSourceString
		ifFound: [ :aSelector | self notifyObjectSpawn: (GtSearchImplementorsFilter selector: aSelector) ]
		ifNone: [  ]
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> browseReferencesAt: aTextPosition [
	"Try to create a references filter for an entity at the given text position and request to browse it"

	self notifyObjectSpawn: (self
		detectReferencesFilterAt: aTextPosition
		ifFound: [ :aReferencesFilter | aReferencesFilter ]
		ifNone: [ GtSearchNullFilter new ])
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> browseReferencesIn: aSourceString [
	"Try to create a references filter for an entity within a given source string and request to browse it"

	self notifyObjectSpawn: (self
		detectReferencesFilterIn: aSourceString
		ifFound: [ :aReferencesFilter | aReferencesFilter ]
		ifNone: [ GtSearchNullFilter new ])
]

{ #category : #'api - actions examples' }
GtPharoSourceCoderPromised >> canExecuteExample [
	<return: #Boolean>

	^ false
]

{ #category : #private }
GtPharoSourceCoderPromised >> classOrMetaClass [
	self
		deprecated: 'Use #behavior instead.'
		transformWith: '`@receiver classOrMetaClass' -> '`@receiver behavior'.
		
	^ self behavior
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> colorAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoColorStyler new.
	coderAddOns addStyler: GtPharoGlamorousColorStyler new.
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> defaultCoderLook [
	^ [ GtMethodCoderHeaderAptitude ]
]

{ #category : #'private - ast' }
GtPharoSourceCoderPromised >> detectBehaviorAt: aTextPosition ifFound: aFoundBlock ifNone: aNoneBlock [
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
GtPharoSourceCoderPromised >> detectBehaviorIn: aSourceString ifFound: aFoundBlock ifNone: aNoneBlock [
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
GtPharoSourceCoderPromised >> detectReferencesFilterAt: aTextPosition ifFound: aFoundBlock ifNone: aNoneBlock [
	"Try to find a name (symbol) in the source code at a given text position of the entity that plays a role
	of the entity reference in the system and create a corresponding references filter.
	Evaluate a found block with the found reference as an argument or none block otherwise. Return the result"
	<return: #Object>
	^ self
		nodeAt: aTextPosition
		ifFound: [ :aNode |
			self
				nodeToReferencesFilter: aNode
				ifFound: aFoundBlock
				ifNone: aNoneBlock ]
		ifNone: aNoneBlock
]

{ #category : #'private - ast' }
GtPharoSourceCoderPromised >> detectReferencesFilterIn: aSourceString ifFound: aFoundBlock ifNone: aNoneBlock [
	"Try to find a name (symbol) in the given source string of the entity that plays a role
	of the entity reference in the system and create a corresponding references filter.
	Evaluate a found block with the found reference as an argument or none block otherwise. Return the result"
	<return: #Object>
	| aNode |

	aNode := GtPharoParser
		parseWithErrors: aSourceString
		startingAt: GtPharoParser startingStateForStatement.

	^ self
		nodeToReferencesFilter: aNode
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'private - ast' }
GtPharoSourceCoderPromised >> detectSelectorAt: aTextPosition ifFound: aFoundBlock ifNone: aNoneBlock [
	"Try to find a message selector at the given source text position and evaluate a found block
	with the found selector as an argument if such selector was found or none block otherwise. Return the result"
	<return: #Object>

	^ self
		nodeAt: aTextPosition
		ifFound: [ :aNode |
			self
				nodeToSelector: aNode
				ifFound: aFoundBlock
				ifNone: aNoneBlock ]
		ifNone: aNoneBlock
]

{ #category : #'private - ast' }
GtPharoSourceCoderPromised >> detectSelectorIn: aSourceString ifFound: aFoundBlock ifNone: aNoneBlock [
	"Try to find a message selector in the given source string and evaluate a found block
	with the found selector as an argument if such selector was found or none block otherwise. Return the result"
	<return: #Object>
	| aNode |

	aNode := GtPharoParser 
		parseWithErrors: aSourceString
		startingAt: GtPharoParser startingStateForStatement.

	^ self
		nodeToSelector: aNode
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'private - actions' }
GtPharoSourceCoderPromised >> evaluationContext [
	<return: #GtSourceCoderEvaluationContext>

	^ GtPharoSourceCoderEvaluationContext new
		requesterObject: self;
		coder: self
]

{ #category : #'private - ast' }
GtPharoSourceCoderPromised >> extractableNodesAt: anIndex [
	"Return a collection of extractable nodes that intersect a given interval"
	<return: #Collection of: #GtPharoProgramNode>

	^ self
		nodeAt: anIndex
		ifFound: [ :aNode |
			aNode isSequence
				ifTrue: [ aNode statements select: [ :eachNode | eachNode intersectsInterval: (anIndex to: anIndex) ] ]
				ifFalse: [ { aNode isMessage ifTrue: [ aNode parent ] ifFalse: [ aNode ] } ] ]
		ifNone: [ #() ]
]

{ #category : #'private - ast' }
GtPharoSourceCoderPromised >> extractableNodesWithin: anInterval [
	"Return a collection of extractable nodes that intersect a given interval"
	<return: #Collection of: #GtPharoProgramNode>

	^ self
		nodeWithin: anInterval
		ifFound: [ :aNode |
			aNode isSequence
				ifTrue: [ aNode statements select: [ :eachNode | eachNode intersectsInterval: anInterval ] ]
				ifFalse: [ { aNode } ] ]
		ifNone: [ #() ]
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> glamorousIconsAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoGlamorousIconStyler new.
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> haltAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 20>
	coderAddOns addStyler: GtPharoHaltStyler new
]

{ #category : #testing }
GtPharoSourceCoderPromised >> hasObjectAttribute [
	<return: #Boolean>

	^ false
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> initializeShortcuts: addOns [
	super initializeShortcuts: addOns.

	addOns
		addShortcut: GtSourceCoderBrowseImplementorsShortcut new;
		addShortcut: GtSourceCoderBrowseReferencesShortcut new;
		addShortcut: GtSourceCoderBrowseBehaviorShortcut new;
		addShortcut: GtSourceCoderDiscardChangesShortcut new
]

{ #category : #testing }
GtPharoSourceCoderPromised >> isForMethod [
	^ false
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> isLocalVariable: aNode [
	^ aNode isLocallyDefined
]

{ #category : #private }
GtPharoSourceCoderPromised >> newCompletionStrategy [
	^ GtPharoCompletionStrategy new
		classOrMetaClass: self behavior;
		yourself
]

{ #category : #'private - ast rb' }
GtPharoSourceCoderPromised >> newRbAST: aString [
	| ast |
	ast := self parseExpression: aString requestor: nil.
	ast doSemanticAnalysis.
	^ ast
]

{ #category : #'private - ast' }
GtPharoSourceCoderPromised >> nodeAt: aTextPosition ifFound: aFoundBlock ifNone: aNoneBlock [
	<return: #Object>
	[
		| theAST innerNode |
		theAST := self astAwait.
		theAST
			withAllNodesDo: [ :node | 
				(aTextPosition between: node startPosition - 1 and: node stopPosition)
					ifTrue: [ innerNode := node ] ].
		
		^ innerNode ifNil: aNoneBlock ifNotNil: aFoundBlock ]
			on: Error
			do: [ :ex | ex return ].

	^ aNoneBlock value
]

{ #category : #'private - ast' }
GtPharoSourceCoderPromised >> nodeToReferencesFilter: aNode ifFound: aFoundBlock ifNone: aNoneBlock [
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
					ifFound: aFoundBlock
					ifNone: aNoneBlock ].
		(aCurrentNode isKindOf: GtPharoSymbolLiteralNode)
			ifTrue: [ ^ aFoundBlock value: (self referencesFilterForLiteral: aCurrentNode asSymbol) ].
		(aCurrentNode isKindOf: GtPharoStringLiteralNode)
			ifTrue: [ ^ aFoundBlock value: (self referencesFilterForString: aCurrentNode value value) ].
		(aCurrentNode isKindOf: GtPharoCharacterLiteralNode)
			ifTrue: [ ^ aFoundBlock value: (self referencesFilterForCharacter: aCurrentNode value value) ].
		(aCurrentNode isKindOf: GtPharoBooleanLiteralNode)
			ifTrue: [ ^ aFoundBlock value: (self referencesFilterForBoolean: aCurrentNode value value) ].
		(aCurrentNode isKindOf: GtPharoNumberLiteralNode)
			ifTrue: [ ^ aFoundBlock value: (self referencesFilterForNumber: aCurrentNode value value) ].
		((aCurrentNode isKindOf: GtPharoMessageNode)
			or: [ aCurrentNode isKindOf: GtPharoMethodPatternNode ])
			ifTrue: [ ^ aFoundBlock value: (self referencesFilterForLiteral: aCurrentNode selector) ].
		(aCurrentNode isKindOf: GtPharoMessageSendNode)
			ifTrue: [ aCurrentNode := aCurrentNode message ]
			ifFalse: [ aCurrentNode := aCurrentNode parent ] ].

	^ aNoneBlock value
]

{ #category : #'private - ast' }
GtPharoSourceCoderPromised >> nodeToSelector: aNode ifFound: aFoundBlock ifNone: aNoneBlock [
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
GtPharoSourceCoderPromised >> nodeWithin: anInterval ifFound: aFoundBlock ifNone: aNoneBlock [
	<return: #Object>

	[
		| theAST |
		theAST := self astAwait.
		^ theAST
			bestNodeFor: anInterval
			ifFound: aFoundBlock
			ifNone: aNoneBlock ]
				on: Error
				do: [ :ex | ex return ].

	^ aNoneBlock value
]

{ #category : #'private - notifying' }
GtPharoSourceCoderPromised >> notifyParseError: aString at: anInteger [
	self announce: (GtCoderParseError new
		coder: self;
		errorMessage: aString;
		location: anInteger)
]

{ #category : #'private - notifying' }
GtPharoSourceCoderPromised >> notifyToolSpawn: aTool withDestination: aSpawnDestination [
	self announce: (GtCoderToolSpawnRequest new 
		tool: aTool;
		spawnDestination: aSpawnDestination;
		coder: self)
]

{ #category : #'api - accessing' }
GtPharoSourceCoderPromised >> object [
	"Deprecated! Use GtPharoSourceCoderViewModel>>#selfObject: instead"
	<return: #Object or: nil>

	self deprecated: 'Use GtPharoSourceCoderViewModel>>#selfObject instead'.

	^ nil
]

{ #category : #'api - accessing' }
GtPharoSourceCoderPromised >> object: anObject [
	"Set an object in the context of which the source code should be modified (may influence self binding)"

	self deprecated: 'Use GtPharoSourceCoderViewModel>>#selfObject: instead'.
]

{ #category : #accessing }
GtPharoSourceCoderPromised >> package [
	^ self attributeNamed: #package
]

{ #category : #accessing }
GtPharoSourceCoderPromised >> packageTag [
	^ self attributeNamed: #packageTag
]

{ #category : #'private - ast rb' }
GtPharoSourceCoderPromised >> parse: aString asExpression: isExpression requestor: aRequestor [
	^ (self behavior ifNil: [ UndefinedObject ]) compiler
		source: aString;
		noPattern: isExpression;
		options: #(+ optionParseErrors + optionSkipSemanticWarnings);
		requestor: aRequestor;
		parse
]

{ #category : #'private - ast rb' }
GtPharoSourceCoderPromised >> parseExpression: aString requestor: aRequestor [
	^ self parse: aString asExpression: true requestor: aRequestor
]

{ #category : #'private - ast rb' }
GtPharoSourceCoderPromised >> parseMethod: aString [
	^ self parse: aString asExpression: false requestor: nil
]

{ #category : #'private - actions' }
GtPharoSourceCoderPromised >> primitiveAnonymousCompile: aSourceString inContext: aGtPharoSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	<return: #CompiledMethod>
	| isForMethod methodClass |

	isForMethod := self isForMethod and: [
		aGtPharoSourceCoderEvaluationContext evaluatedInterval = (1 to: aGtPharoSourceCoderEvaluationContext sourceString size) ].
	
	isForMethod
		ifFalse: [ aGtPharoSourceCoderEvaluationContext withSnippetBindingStrategy ].

	methodClass := aGtPharoSourceCoderEvaluationContext runtimeContext
		ifNil: [ aGtPharoSourceCoderEvaluationContext receiverObject class ]
		ifNotNil: [ :aContext | aContext methodClass ].

	^ GtPharoCodeModifier current critical: [
		self class compiler
			source: aSourceString;
			class: methodClass newAnonymousSubclass;
			context: aGtPharoSourceCoderEvaluationContext runtimeContext;
			requestor: aGtPharoSourceCoderEvaluationContext;
			noPattern: isForMethod not;
			failBlock: anEvaluationFailBlock;
			compile ]
]

{ #category : #'private - actions' }
GtPharoSourceCoderPromised >> primitiveDebug: aSourceString inContext: aGtPharoSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	| aCompiledMethodToDebug |

	aCompiledMethodToDebug := self
		primitiveAnonymousCompile: aSourceString
		inContext: aGtPharoSourceCoderEvaluationContext
		onFailDo: [ ^ anEvaluationFailBlock value ].

	self class
		debug: aCompiledMethodToDebug
		receiver: aGtPharoSourceCoderEvaluationContext receiverObject
		in: aGtPharoSourceCoderEvaluationContext runtimeContext
]

{ #category : #'private - actions' }
GtPharoSourceCoderPromised >> primitiveEvaluate: aSourceString inContext: aGtPharoSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	| aCompiledMethodToEvaluate |

	aCompiledMethodToEvaluate := self
		primitiveAnonymousCompile: aSourceString
		inContext: aGtPharoSourceCoderEvaluationContext
		onFailDo: [ ^ anEvaluationFailBlock value ].

	^ aGtPharoSourceCoderEvaluationContext receiverObject
		withArgs: (aGtPharoSourceCoderEvaluationContext runtimeContext
			ifNil: [ #() ]
			ifNotNil: [ { aGtPharoSourceCoderEvaluationContext runtimeContext } ])
		executeMethod: aCompiledMethodToEvaluate
]

{ #category : #accessing }
GtPharoSourceCoderPromised >> protocol [
	^ #accessing
]

{ #category : #'private - ast rb' }
GtPharoSourceCoderPromised >> rbAST [
	| source |

	"The AST should be built out of the `characters` of the source text.
	This is needed to support `crlf` and logical items
	see https://github.com/feenkcom/gtoolkit/issues/593"
	source := self currentSourceString.
	^ [ self newRbAST: source ]
		on: Error
		do: [ :ex | ex return: nil ]
]

{ #category : #'private - ast' }
GtPharoSourceCoderPromised >> referencesFilterForBoolean: aBooleanAsString [
	"aBooleanAsString would be a string 'true', which should be evaluated to get a boolean"

	^ self referencesFilterForLiteral: (Object evaluate: aBooleanAsString)
]

{ #category : #'private - ast' }
GtPharoSourceCoderPromised >> referencesFilterForCharacter: aCharacterAsString [
	"aCharacterAsString would be a string '$a', which should be evaluated to get a character"

	^ self referencesFilterForLiteral: (Object evaluate: aCharacterAsString)
]

{ #category : #'private - ast' }
GtPharoSourceCoderPromised >> referencesFilterForLiteral: anObject [
	^ GtSearchReferencesFilter literal: anObject
]

{ #category : #'private - ast' }
GtPharoSourceCoderPromised >> referencesFilterForNumber: aNumberAsString [
	"aNumberAsString would be a string '42', which should be evaluated to get a boolean"

	^ self referencesFilterForLiteral: (Object evaluate: aNumberAsString)
]

{ #category : #'private - ast' }
GtPharoSourceCoderPromised >> referencesFilterForString: aString [
	"we have to dispatch through the compiler and to evaluate: the string, otherwise it will not be searched for
	because it is compared by identity and compiler does some string optimizations"

	^ self referencesFilterForLiteral: (Object evaluate: aString)
]

{ #category : #'private - ast' }
GtPharoSourceCoderPromised >> referencesFilterForSymbol: aSymbol [
	^ self referencesFilterForLiteral: aSymbol
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> removeRefactoringAttribute [
	self sourceText
		clearAttributes: [ :each | each class = GtRefactoringChangesAttribute ]
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> renameAt: aTextPosition in: aSourceCoderViewModel [
	self
		nodeAt: aTextPosition
		ifFound: [ :aNode | self renameNode: aNode in: aSourceCoderViewModel ]
		ifNone: [  ]
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> renameClassIn: aSourceCoderViewModel node: aVariableNode [
	(GtRenameClassController new
		sourceCoderViewModel: aSourceCoderViewModel;
		originalNode: aVariableNode) execute
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> renameClassVariableIn: aSourceCoderViewModel node: aVariableNode [
	(GtRenameClassVariableController new
		sourceCoderViewModel: aSourceCoderViewModel;
		originalNode: aVariableNode) execute
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> renameInstanceVariableIn: aSourceCoderViewModel node: aVariableNode [
	(GtRenameInstanceVariableController new
		sourceCoderViewModel: aSourceCoderViewModel;
		originalNode: aVariableNode) execute
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> renameMethod: aSourceCoderViewModel node: aMessageOrMethodOrMethodPatternNode [
	(GtRenameMethodController new
		sourceCoderViewModel: aSourceCoderViewModel;
		originalNode: aMessageOrMethodOrMethodPatternNode) execute
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> renameNode: aNode in: aSourceCoderViewModel [
	(aNode isMessage or: [ aNode isMethod or: [ aNode isMethodPattern ] ])
		ifTrue: [ ^ self renameMethod: aSourceCoderViewModel node: aNode ].
	aNode isVariable
		ifTrue:
			[ (self isLocalVariable: aNode) ifTrue: [ ^ self renameTemporaryIn: aSourceCoderViewModel node: aNode ].
			(self behavior allInstVarNames includes: aNode name value)
				ifTrue: [ ^ self renameInstanceVariableIn: aSourceCoderViewModel node: aNode ].
			(self behavior classVariables anySatisfy: [ :assoc | assoc key asString = aNode name value ])
				ifTrue: [ ^ self renameClassVariableIn: aSourceCoderViewModel node: aNode ].
			Smalltalk globals
				at: aNode name value asSymbol
				ifPresent: [ :cls | (cls isKindOf: Class) ifTrue: [ ^ self renameClassIn: aSourceCoderViewModel node: aNode ] ] ]
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> renameTemporaryIn: aSourceCoderViewModel node: aVariableNode [
	| action locations announcement definer otherCoders renameAttributes originalSource |
	originalSource := aSourceCoderViewModel sourceText from: aVariableNode startPosition to: aVariableNode stopPosition.
	locations := OrderedCollection new.
	definer := aVariableNode whoDefines.
	announcement := GtCoderRenameTemporaryRequestedAnnouncement new.
	definer isNil
		ifTrue:
			[ announcement variableName: aVariableNode name source.
			self announce: announcement ].
	otherCoders := announcement interestedCoders reject: [ :each | each == self ].
	(definer ifNil: [ aVariableNode topParent ])
		withAllNodesDo: [ :each | each = aVariableNode ifTrue: [ locations add: each sourceInterval ] ].
	action := GtRenameAction2 locations: locations textualCoderViewModel: aSourceCoderViewModel.
	action forVariableOrUnaryMessage.
	renameAttributes := OrderedCollection new.
	otherCoders
		do:
			[ :each | 
			each
				implicitVariableReferencesTo: aVariableNode variableName
				do:
					[ :node | 
					| attribute |
					attribute := GtRenamePreviewAttribute new text: originalSource.
					(each sourceText from: node startPosition to: node stopPosition) attributes: {attribute}.
					renameAttributes add: attribute ].
			each sourceChanged ].
	action
		when: GtRenameActionAnnouncement
		do:
			[ :ann | 
			ann eventType = #textUpdated
				ifTrue: [ renameAttributes do: [ :each | each updateText: ann renameAction newName asRopedText ] ].
			ann eventType = #uninstall
				ifTrue:
					[ otherCoders
						do:
							[ :each | 
							each sourceText clearAttributes: [ :attr | attr isKindOf: GtRenamePreviewAttribute ].
							each sourceChanged ] ].
			ann eventType = #accept
				ifTrue: [ otherCoders do: [ :each | each renameImplicitTemporary: aVariableNode variableName to: action newName ] ] ].
	action install.
	^ action
]

{ #category : #'api - accessing' }
GtPharoSourceCoderPromised >> source [
	<return: #String>

	self
		deprecated: 'Use #currentSourceString instead'
		transformWith: '`@receiver source' -> '`@receiver currentSourceString'.
		
	^ self currentSourceString
]

{ #category : #private }
GtPharoSourceCoderPromised >> validateSyntax [
	<return: #Boolean>

	[ self computeAst ]
		on: SmaCCParserError
		do: [ :ex | 
			self notifyParseError: ex messageText at: ex tag position.
			^ false ].
	^ true
]

{ #category : #'private - ast' }
GtPharoSourceCoderPromised >> variableNodeAt: aTextPosition ifFound: aFoundBlock ifNone: aNoneBlock [
	"Try to find a variable node ${class:GtPharoVariableNode}$ at a given text position and evaluate a found
	block if such node exists and none block otherwise. Return the result"
	<return: #Object>
	[
		| theAST |
		theAST := self astAwait.
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
GtPharoSourceCoderPromised >> variableNodeIn: aSourceString ifFound: aFoundBlock ifNone: aNoneBlock [
	"Try to extract a variable node ${class:GtPharoVariableNode}$ in a given string and evaluate a found block
	if such node was found and a none block otherwise. Return the result."
	<return: #Object>
	| eachNode |

	eachNode := GtPharoParser 
		parseWithErrors: aSourceString
		startingAt: GtPharoParser startingStateForStatement.

	[ eachNode isNil ]
		whileFalse: [ 
			(eachNode isKindOf: GtPharoVariableNode)
				ifTrue: [ ^ aFoundBlock value: eachNode ].
			eachNode := eachNode parent ].

	^ aNoneBlock value
]

{ #category : #'private - ast' }
GtPharoSourceCoderPromised >> variableNodeToBehavior: aVariableNode ifFound: aFoundBlock ifNone: aNoneBlock [
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
GtPharoSourceCoderPromised >> variableNodeToReferencesFilter: aVariableNode ifFound: aFoundBlock ifNone: aNoneBlock [
	"Convert a given variable node to the references filter and evaluate
	a found block if such filter can be created, evaluate none block otherwise. Return the result"
	<return: #Object>
	| aVariableName aVariableIndex aDefiningClass aBinding |
	
	aVariableName := aVariableNode name source.
	aVariableIndex := self behavior instVarIndexFor: aVariableName.
	aVariableIndex > 0
		ifTrue: [
			aDefiningClass := self behavior whichClassDefinesInstVar: aVariableName.
			^ aFoundBlock value: (GtSearchInstanceSlotReferenceFilter
				forClassAndSubclasses: aDefiningClass
				andVariable: aVariableName) ].

	aBinding := self behavior bindingOf: aVariableName.
	aBinding notNil
		ifTrue: [ ^ aFoundBlock value: (GtSearchReferencesFilter literal: aBinding) ].
		
	"At this point we know that it is not an instance/class varaible, nor it is a binding.
	We therefore fallback to the basic literal references filter"

	^ aFoundBlock value: (self referencesFilterForLiteral: aVariableName asSymbol)
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> withHeader [
	self coderLook: [ GtMethodCoderHeaderAptitude ]
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> withoutHeader [
	self coderLook: nil
]

{ #category : #'as yet unclassified' }
GtPharoSourceCoderPromised >> zincAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoZincStyler new.
	coderAddOns addStyler: GtPharoZincApplicationFormUrlEncodedEntityStyler new.
]
