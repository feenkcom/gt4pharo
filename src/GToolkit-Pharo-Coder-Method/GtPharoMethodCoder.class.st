"
I extend a {{gtClass:GtSourceCoder}} with the knowledge of how to edit a method. In particular, I am aware of different types of methods and provide a wider variety of refactorings and actions. 
"
Class {
	#name : #GtPharoMethodCoder,
	#superclass : #GtPharoSourceCoder,
	#instVars : [
		'methodBehavior',
		'selector'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Coder'
}

{ #category : #'instance creation' }
GtPharoMethodCoder class >> forClass: aBehavior source: aString [
	^ self new
		forClass: aBehavior source: aString;
		yourself
]

{ #category : #'instance creation' }
GtPharoMethodCoder class >> forExample: anExample [
	^ self new
		forExample: anExample;
		yourself
]

{ #category : #'instance creation' }
GtPharoMethodCoder class >> forMethod: aCompiledMethod [
	^ self new
		forMethod: aCompiledMethod;
		yourself
]

{ #category : #'instance creation' }
GtPharoMethodCoder class >> forMethod: aCompiledMethod in: aBehavior [
	^ self new
		forMethod: aCompiledMethod in: aBehavior;
		yourself
]

{ #category : #'instance creation' }
GtPharoMethodCoder class >> forNewMethod: aBehavior [
	^ self forClass: aBehavior source: ''
]

{ #category : #'instance creation' }
GtPharoMethodCoder class >> forObject: anObject andSelector: aSymbol [
	^ self forMethod: anObject class >> aSymbol
]

{ #category : #'coder selection' }
GtPharoMethodCoder class >> isCoderValidFor: aCompiledMethod [
	^true
]

{ #category : #'coder selection' }
GtPharoMethodCoder class >> priority [
	^1000
]

{ #category : #'api - refactorings' }
GtPharoMethodCoder >> addClassVariable: aString [
	| refactoring |
	refactoring := RBAddClassVariableRefactoring
		variable: aString
		class: self behavior instanceSide.
	GtPharoCodeModifier critical: [ refactoring execute ].

	"and restyle the text"
	self requestStyleSourceText
]

{ #category : #'api - refactorings' }
GtPharoMethodCoder >> addInstanceVariable: aString [
	| refactoring |
	refactoring := RBAddInstanceVariableRefactoring
		variable: aString
		class: self behavior.
	GtPharoCodeModifier critical: [ refactoring execute ].

	self requestStyleSourceText
]

{ #category : #'api - accessing' }
GtPharoMethodCoder >> behavior [
	<return: #Behavior>

	^ self methodBehavior
		realBehaviorDo: [ :aBehavior | aBehavior ]
		ifAbsent: [ UndefinedObject ]
]

{ #category : #'api - accessing' }
GtPharoMethodCoder >> behavior: aBehavior [
	self methodBehavior: (GtPharoCoderBehavior explicit: aBehavior)
]

{ #category : #accessing }
GtPharoMethodCoder >> browseHierarchyImplementorsAt: aTextPosition requesterObject: aRequester [
	self
		detectSelectorAt: aTextPosition
		ifFound: [ :aSelector :anAstNode | 
			self
				notifyObjectSpawn: (aSelector gtImplementors
						requesterContext: (self newFilterContext
							selectorInPosition: aSelector;
							nodeInPosition: anAstNode;
							selectedScope: (GtSearchScopedMethodsClassHierarchyScope new itemClass: self behavior)))
				requesterObject: aRequester ]
		ifNone: [  ]
]

{ #category : #accessing }
GtPharoMethodCoder >> browseHierarchyReferencesAt: aTextPosition requesterObject: aRequester [
	self
		detectSelectorAt: aTextPosition
		ifFound: [ :aSelector :anAstNode | 
			self
				notifyObjectSpawn: (aSelector gtSenders
						requesterContext: (self newFilterContext
							selectorInPosition: aSelector;
							nodeInPosition: anAstNode;
							selectedScope: (GtSearchScopedMethodsClassHierarchyScope new itemClass: self behavior)))
				requesterObject: aRequester ]
		ifNone: [  ]
]

{ #category : #testing }
GtPharoMethodCoder >> canCompileMethodIn: newClass [
	| ast modelClass pools variables model |
	ast := self rbAST.
	variables := Set new.
	ast
		nodesDo: [ :node | 
			(node isSelfOrSuper not
				and: [ node isVariable and: [ node gtIsLocal not ] ])
				ifTrue: [ variables add: node name ] ].
	model := RBNamespace new.
	modelClass := model classFor: newClass.
	pools := {Smalltalk} , modelClass instanceSide sharedPools.
	^ variables
		allSatisfy: [ :each | 
			(modelClass definesVariable: each)
				or: [ pools anySatisfy: [ :pool | pool includesKey: each asSymbol ] ] ]
]

{ #category : #'api - actions examples' }
GtPharoMethodCoder >> canExecuteExample [
	<return: #Boolean>

	^ self example
		ifNil: [ false ]
		ifNotNil: [ :anExample | anExample canBeExecuted ]
]

{ #category : #testing }
GtPharoMethodCoder >> canMoveMethodToInstanceOrClass [
	| oldClass newClass |
	oldClass := self behavior.
	newClass := oldClass isMeta
		ifTrue: [ oldClass soleInstance ]
		ifFalse: [ oldClass class ].
	(newClass includesSelector: self currentSelector)
		ifTrue: [ ^ false ].
	^ self canCompileMethodIn: newClass
]

{ #category : #'api - accessing' }
GtPharoMethodCoder >> category [
	self
		deprecated: 'Use #protocol instead.'
		transformWith: '`@receiver category' -> '`@receiver protocol'.

	^ self protocol
]

{ #category : #'api - accessing' }
GtPharoMethodCoder >> category: aSymbol [
	self
		deprecated: 'Use #protocol: instead.'
		transformWith: '`@receiver category: `@arg' -> '`@receiver protocol: `@arg'.

	self protocol: aSymbol
]

{ #category : #private }
GtPharoMethodCoder >> changedSourceForCurrentMethod: aRefactoryChange [
	aRefactoryChange changes
		reverseDo: [ :each | 
			((each isKindOf: RBAddMethodChange)
				and: [ each selector = self currentSelector
						and: [ self behavior = each changeClass ] ])
				ifTrue: [ ^ each source ] ].
	^ nil
]

{ #category : #accessing }
GtPharoMethodCoder >> classOrMetaClass: aBehavior [
	self
		deprecated: 'Use #behavior: instead.'
		transformWith: '`@receiver classOrMetaClass: `@arg' -> '`@receiver behavior: `@arg'.

	self behavior: aBehavior
]

{ #category : #'private - actions' }
GtPharoMethodCoder >> clearExample [
	self unsubscribeFromExample.
	self removeAttributeNamed: #example.
]

{ #category : #'private - actions' }
GtPharoMethodCoder >> clearTestCase [
	self removeAttributeNamed: #testCase.
]

{ #category : #'api - text' }
GtPharoMethodCoder >> collapsedText [
	<return: #BlText>

	^ self collapsedTextPromise wait
]

{ #category : #'api - text' }
GtPharoMethodCoder >> collapsedTextPromise [
	<return: #TAsyncPromise of: #BlText>

	^ self currentSelectorPromise then: [ :aSelector | aSelector asRopedText ]
]

{ #category : #'api - actions' }
GtPharoMethodCoder >> compile [
	"Try to compile the current source code and return true if it was successful, false otherwise"
	<return: #Boolean>

	^ self compileInContext: self evaluationContext
]

{ #category : #'api - actions' }
GtPharoMethodCoder >> compileInContext: aGtPharoSourceCoderEvaluationContext [
	"Try to compile the current source code and return true if it was successful, false otherwise"

	<return: #Boolean>
	| aPreviousCompiledMethod aChange aNewCompiledMethod |
	aPreviousCompiledMethod := self compiledMethod.	"we should use #currentSelector instead of #selector because we care
	about the `current` state of the coder (#selector may be nil for new methods)"
	self currentSelector ifNil: [ ^ false ].

	aGtPharoSourceCoderEvaluationContext hasTargetBehavior
		ifFalse: [ ^ GtPharoMethodCoderTargetBehaviorNotDefined signal ].

	aChange := self
			createCompileMethodChangeIn: aGtPharoSourceCoderEvaluationContext targetBehavior
			inContext: aGtPharoSourceCoderEvaluationContext.
	(self
		handleCompilerErrorsDuring: [ GtPharoCodeModifier current performRefactoryChange: aChange ]
		inContext: aGtPharoSourceCoderEvaluationContext) ifFalse: [ ^ false ].

	aChange definedSelector ifNil: [ ^ false ].

	aNewCompiledMethod := aChange changeClass >> aChange definedSelector.
	self forMethod: aNewCompiledMethod.

	self notifyMethodRecompiledFrom: aPreviousCompiledMethod to: aNewCompiledMethod.

	^ true
]

{ #category : #accessing }
GtPharoMethodCoder >> compiledMethod [
	<return: #CompiledMethod or: nil>
	
	^ self existsInTheSystem
		ifTrue: [ self behavior >> self selector ]
		ifFalse: [ nil ]
]

{ #category : #'api - ast' }
GtPharoMethodCoder >> computeAst: theSourceString [
	^ GtPharoParser
		parseWithErrors: theSourceString
		startingAt: self startingStateForAstComputation
]

{ #category : #private }
GtPharoMethodCoder >> createCompileMethodChange [
	<return: #RBAddMethodChange or: nil>

	^ self methodBehavior
		realBehaviorDo: [ :aBehavior | self createCompileMethodChangeIn: aBehavior inContext: self evaluationContext ]
		ifAbsent: [ nil ]
]

{ #category : #private }
GtPharoMethodCoder >> createCompileMethodChangeIn: aBehavior inContext: aGtPharoSourceCoderEvaluationContext [
	<return: #RBAddMethodChange>
	| aSourceString |
	
	aSourceString := self currentSourceString.

	aGtPharoSourceCoderEvaluationContext
		sourceString: aSourceString;
		evaluatedInterval: (1 to: aSourceString size);
		evaluatedSourceString: aSourceString.

	^ self 
		forPharo12AndNewer: [
			"TODO: check what happends when we get errors during compilation"
			self protocol
				ifNil: [
					RBAddMethodChange
						compile: aSourceString
						in: aBehavior ]
				ifNotNil: [ :aCategory | 
					RBAddMethodChange
						compile: aSourceString
						in: aBehavior
						classified: aCategory ] ] 
		forPharo11: [ 
			self protocol
				ifNil: [
					RBAddMethodChange
						compile: aSourceString
						in: aBehavior
						for: aGtPharoSourceCoderEvaluationContext ]
				ifNotNil: [ :aCategory | 
					RBAddMethodChange
						compile: aSourceString
						in: aBehavior
						classified: aCategory
						for: aGtPharoSourceCoderEvaluationContext ] ]
]

{ #category : #private }
GtPharoMethodCoder >> createRefactoringModel [

	| model |
	model := Smalltalk createRbNamespace onEnvironment:
		         RBBrowserEnvironment new.
	(((model classFor: self behavior) directlyDefinesMethod:
		  self currentSelector) not or: [ 
		 ((model classFor: self behavior) sourceCodeFor:
			  self currentSelector) ~= self currentSourceText asString ]) 
		ifTrue: [ 
			(model classFor: self behavior)
				compile: self sourceText asString
				classified: self protocol ].
	^ model
]

{ #category : #accessing }
GtPharoMethodCoder >> currentSelector [
	<return: #Symbol>

	^ self currentSelectorPromise wait
]

{ #category : #accessing }
GtPharoMethodCoder >> currentSelectorPromise [
	<return: #Symbol>

	selector
		ifNotNil: [ ^ selector asAsyncPromise ].

	^ self ast then: [ :aGtCoderAst |
		| anAst |
		
		anAst := aGtCoderAst ast.
		anAst isMethod
			ifFalse: [ #faulty ]
			ifTrue: [ anAst selector ifNil: [ #faulty ] ] ]
]

{ #category : #'api - actions examples' }
GtPharoMethodCoder >> debugExample [
	self isModified
		ifTrue: [ self save
			ifFalse: [ ^ self ] ].
	self example openingDebugger result
]

{ #category : #'api - actions' }
GtPharoMethodCoder >> ensureSave [
	"Try to save the current method validating syntax and return `true` if save was succesful, false otherwise"
	<return: #Boolean>
	self isModified
		ifTrue: [
			self save
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #'private - actions' }
GtPharoMethodCoder >> evaluateSelector: aSymbol inContext: aGtPharoSourceCoderEvaluationContext thenDo: aThenBlock [
	"Evaluate a given source code and show the print string if needed"
	| aReceiver aSourceString aResult evaluationArguments |

	"we can not wrap everything in a critical: because if there is an exception while evaluating
	the source code the current running process will be suspended, meaning that the very next evaluation
	will indefinitely wait when trying to enter a critical section."
	self critical: [
		aReceiver := aGtPharoSourceCoderEvaluationContext receiverObject.
		aSourceString := self currentSourceString ].
	
	aGtPharoSourceCoderEvaluationContext
		sourceString: aSourceString;
		evaluatedSourceString: aSourceString;
		evaluatedInterval: (1 to: aSourceString size).
		
	evaluationArguments := GtPharoMethodArgumentsCollector new
		evaluationContext: aGtPharoSourceCoderEvaluationContext;
		targetBehavior: aGtPharoSourceCoderEvaluationContext targetBehavior receiver: aReceiver selector: aSymbol;
		collect.
		
	aGtPharoSourceCoderEvaluationContext evaluatedCode: (
		GtPharoEvaluatedSelector new
			receiver: aReceiver;
			methodSelector: aSymbol;
			methodArguments: evaluationArguments).

	aResult := self
		evaluateBlock: [ aReceiver perform: aSymbol withArguments: evaluationArguments ]
		onErrorDo: [ :aResultWithError | aResultWithError evaluationContext: aGtPharoSourceCoderEvaluationContext ].

	aResult evaluationContext: aGtPharoSourceCoderEvaluationContext.

	self notifyEvaluatedWithResult: aResult.
	aThenBlock cull: aResult.

	^ aResult
]

{ #category : #'private - evaluation' }
GtPharoMethodCoder >> evaluationContext [
	| anEvaluationContext aMethodOrigin |
	
	anEvaluationContext := super evaluationContext.
	
	aMethodOrigin := self methodOrigin.
	"By default we should aim to compile the method in the same behavior as the method's origin"
	aMethodOrigin behaviorDo: [ :aBehavior | 
		anEvaluationContext targetBehavior: aBehavior ].
	
	"however, when a compiled method does not exist it is not possible to determine its origin.
	In that case we should rely solely on the defined method behavior, if any"
	aMethodOrigin isUnknownOrigin
		ifTrue: [
			self methodBehavior
				realBehaviorDo: [ :aBehavior | 
					anEvaluationContext targetBehavior: aBehavior ] ].

	^ anEvaluationContext
]

{ #category : #'api - actions examples' }
GtPharoMethodCoder >> example [
	<return: #GtExampleWithResult or: nil>
	| anExampleWithResult |
	anExampleWithResult := self attributeNamed: #example.
	anExampleWithResult ifNil: [ 
		anExampleWithResult := self compiledMethod ifNotNil: [ :aCompiledMethod | 
			self methodBehavior 
				ifRealSubclassBehaviorSameAsRealBehaviorDo: [ :aBehavior |
					self explicitProviderClass 
						ifNotNil: [ :aProviderClass |
							aBehavior = aProviderClass 
								ifFalse: [ 
									(aCompiledMethod gtExampleWithProviderClass: aProviderClass) 
										ifNotNil: [ :anExample | 
											aCompiledMethod gtExampleWithResultForExample: anExample ] ]
								ifTrue: [ aCompiledMethod gtExampleWithResult ] ]
						ifNil: [ aCompiledMethod gtExampleWithResult ] ]
				ifDifferentDo: [ :aSubclassBehavior |
					(aCompiledMethod gtExampleWithProviderClass: aSubclassBehavior) 
						ifNotNil: [ :anExample | 
							aCompiledMethod gtExampleWithResultForExample: anExample ] ]
				ifAbsent: [ nil ] ].
		
		anExampleWithResult ifNotNil: [ 
			self 
				assert: [ anExampleWithResult asExampleWithResult == anExampleWithResult ]
				description: [ 'Example with result expected: {1}' 
					format: { anExampleWithResult } ].
			self example: anExampleWithResult ] ].

	self compiledMethod ifNotNil: [ :aCompiledMethod | 
		self
			assert: [ aCompiledMethod selector = self selector
					and: [ aCompiledMethod methodClass = self behavior ] ]
			description: [ 'Example and compiled method are out of sync: example is {1}; method is {2}'
					format: {anExampleWithResult gtDisplayString.
							aCompiledMethod} ] ].

	^ anExampleWithResult
]

{ #category : #'api - actions examples' }
GtPharoMethodCoder >> example: anExampleWithResult [
	| aCompiledMethod |
	self unsubscribeFromExample.
	self
		attributeNamed: #example
		put: anExampleWithResult asExampleWithResult.
	self explicitProviderClass: anExampleWithResult providerClass.
	aCompiledMethod := anExampleWithResult method.
	(aCompiledMethod selector = self selector
		and: [ aCompiledMethod methodClass = self behavior ])
		ifFalse: [ self error: 'Can not assign example of the wrong method' ].
	self example announcer weak
		when: GtExampleExecuted send: #handleExampleExecuted: to: self;
		when: GtExampleArgumentsChanged
			send: #handleExampleArgumentsChanged:
			to: self
]

{ #category : #'api - actions examples' }
GtPharoMethodCoder >> exampleResult [
	<return: #GtExampleResult or: nil>
	^ self example ifNotNil: #result
]

{ #category : #testing }
GtPharoMethodCoder >> existsInTheSystem [
	"Return true if a method with the given #selector exists in the behavior"
	<return: #Boolean>

	self behavior
		ifNil: [ ^ false ].

	self behavior isObsolete
		ifTrue: [ ^ false ].

	self selector
		ifNil: [ ^ false ].

	^ self behavior includesSelector: self selector
]

{ #category : #accessing }
GtPharoMethodCoder >> explanationLink [
	^ self attributeNamed: #explanationLink
]

{ #category : #accessing }
GtPharoMethodCoder >> explanationLink: anExplanation [
	self explanationLink == anExplanation
		ifTrue: [ ^ self ].

	self attributeNamed: #explanationLink put: anExplanation.
	
	self requestStyleSourceText.
	self requestUpdateAddOns
]

{ #category : #'api - header' }
GtPharoMethodCoder >> explicitProviderClass [
	^ self attributeNamed: #providerClass.
]

{ #category : #'api - actions examples' }
GtPharoMethodCoder >> explicitProviderClass: aClass [
	self attributeNamed: #providerClass put: aClass 
]

{ #category : #private }
GtPharoMethodCoder >> findSeparatorBetweenPatternAndBodyIn: aMethodNode [
	| startIndex char source |
	source := aMethodNode completeSource.
	startIndex := aMethodNode pattern stopPosition + 1.
	[ startIndex <= source size and: [ (char := source at: startIndex) isSeparator and: [ char ~= Character cr ] ] ]
		whileTrue: [ startIndex := startIndex + 1 ].
	^ startIndex
]

{ #category : #initialize }
GtPharoMethodCoder >> forClass: aBehavior source: aString [
	self behavior: aBehavior.
	self sourceCode: (GtCoderExplicitStringSource new source: aString)
]

{ #category : #initialize }
GtPharoMethodCoder >> forExample: anExampleWithResult [
	anExampleWithResult methodClass = anExampleWithResult providerClass
		ifTrue: [ 
			self forMethod: anExampleWithResult method ]
		ifFalse: [ 
			self
				forMethod: anExampleWithResult method
				in: anExampleWithResult providerClass ].
	self example: anExampleWithResult
]

{ #category : #initialize }
GtPharoMethodCoder >> forMethod: aCompiledMethod [
	self methodBehavior:(GtPharoCoderBehavior explicit: aCompiledMethod methodClass).
	self selector: aCompiledMethod selector.
	self sourceCode: (GtCoderCompiledMethodTextSource new compiledMethod: aCompiledMethod).
	self protocol: aCompiledMethod protocolName
]

{ #category : #initialize }
GtPharoMethodCoder >> forMethod: aCompiledMethod in: aBehavior [
	self
		methodBehavior: (GtPharoCoderBehavior
				from: (aCompiledMethod methodClass isClassSide
						ifTrue: [ aBehavior classSide ]
						ifFalse: [ aBehavior instanceSide ])
				to: aCompiledMethod methodClass).
	self selector: aCompiledMethod selector.
	self
		sourceCode: (GtCoderCompiledMethodTextSource new compiledMethod: aCompiledMethod).
	self protocol: aCompiledMethod protocolName.

	self methodBehavior
		ifRealSubclassBehaviorSameAsRealBehaviorDo: [ :aRealBehavior |  ]
		ifDifferentDo: [ :aRealBehavior | self explicitProviderClass: aRealBehavior ]
		ifAbsent: [ nil ]
]

{ #category : #accessing }
GtPharoMethodCoder >> formatWithRequesterObject: aRequester [
	| ast |
	ast := [ RBParser parseMethod: self currentSourceString ]
			on: RBParser gtParseErrorClass
			do: [ :ex | ^ self notifyParseError: ex requesterObject: aRequester ].

	self currentSourceString: ast formattedCode
]

{ #category : #'gt-extensions' }
GtPharoMethodCoder >> gtDiffViewFor: aView [
	"<gtView>
	(methodSource = self newMethodSource) ifTrue: [ ^ aView ].
	^ aView textEditor
		title: 'Diff' translated;
		priority: 11;
		text: [ :anEditor | 
			GtEpiceaDiffStencil new
				from: methodSource;
				to: self newMethodSource;
				create ]"
]

{ #category : #'examples - event handling' }
GtPharoMethodCoder >> handleExampleArgumentsChanged: aGtExampleArgumentsChanged [
	self requestUpdateAddOns
]

{ #category : #'examples - event handling' }
GtPharoMethodCoder >> handleExampleExecuted: aGtExampleExecuted [
	self requestStyleSourceText.
	self announce: (GtCoderExampleExecuted new 
		coder: self;
		example: aGtExampleExecuted example)
]

{ #category : #'private - refactorings' }
GtPharoMethodCoder >> isAccessorMethodFor: aNode [
	| statement |
	aNode methodNode body statements size = 1
		ifFalse: [ ^ false ].
	aNode methodNode body variables isEmpty
		ifFalse: [ ^ false ].
	aNode parent isReturn
		ifTrue: [ statement := aNode parent.
			^ statement parent isSequence
				and: [ statement parent parent == aNode methodNode
						and: [ aNode methodNode selector isUnary ] ] ].
	aNode parent isAssignment
		ifFalse: [ ^ false ].
	(aNode methodNode selector numArgs = 1
		and: [ aNode parent value = aNode methodNode pattern variables first ])
		ifFalse: [ ^ false ].
	statement := aNode parent.
	statement parent isReturn
		ifTrue: [ statement := statement parent ].
	^ statement parent isSequence
		and: [ statement parent parent == aNode methodNode ]
]

{ #category : #testing }
GtPharoMethodCoder >> isForMethod [
	^ true
]

{ #category : #testing }
GtPharoMethodCoder >> isForMethod: aCompiledMethod [
	^ self behavior = aCompiledMethod methodClass
		and: [ self selector = aCompiledMethod selector ]
]

{ #category : #testing }
GtPharoMethodCoder >> isFromTrait [
	^ self compiledMethod
		ifNil: [ false ]
		ifNotNil: [ :aMethod | aMethod isFromTrait ]
]

{ #category : #testing }
GtPharoMethodCoder >> isMeta [
	"Return true if the method is implemented in the metaclass (~ class side)"
	<return: #Boolean>

	^ self behavior isMeta
]

{ #category : #testing }
GtPharoMethodCoder >> isNewMethod [
	^ self currentSourceString isEmpty
]

{ #category : #testing }
GtPharoMethodCoder >> isOverridden [

	| sel |
	sel := self currentSelector.
	sel isNil ifTrue: [ ^ false ].
	self behavior allSubclassesDo: [ :cls | 
		(cls includesSelector: sel) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #testing }
GtPharoMethodCoder >> isOverriding [

	| sel |
	sel := self currentSelector.
	^ sel notNil and: [ 
		  self behavior superclass
			  ifNil: [ false ]
			  ifNotNil: [ :spr | (spr whichClassIncludesSelector: sel) notNil ] ]
]

{ #category : #'api - accessing' }
GtPharoMethodCoder >> methodBehavior [
	<return: #GtPharoCoderBehavior>

	^ methodBehavior
]

{ #category : #'api - accessing' }
GtPharoMethodCoder >> methodBehavior: aGtMethodCoderBehavior [
	self
		assert: [ aGtMethodCoderBehavior isKindOf: GtPharoCoderBehavior ]
		description: [ 'Behavior must be reifined as an object' ].
	methodBehavior == aGtMethodCoderBehavior ifFalse: [ 
		methodBehavior := aGtMethodCoderBehavior. 
		self announce: (GtCoderBehaviorChanged new 
			newBehavior: aGtMethodCoderBehavior;
			coder: self).
		self requestStyleSourceText ]
]

{ #category : #'api - accessing' }
GtPharoMethodCoder >> methodOrigin [
	<return: #GtPharoMethodOrigin>
	| aCompiledMethod anOriginBehavior aMethodBehavior |
	
	aCompiledMethod := self compiledMethod
		ifNil: [ ^ GtPharoMethodUnknownOrigin new ].
	
	anOriginBehavior := aCompiledMethod origin.
	aMethodBehavior := aCompiledMethod methodClass.

	(anOriginBehavior = aMethodBehavior)
		ifTrue: [ ^ GtPharoMethodSameOrigin new 
			behavior: aMethodBehavior method: aCompiledMethod ].

	anOriginBehavior isTrait
		ifTrue: [ ^ GtPharoMethodTraitOrigin new 
			trait: anOriginBehavior method: aCompiledMethod ].	
		
	^ GtPharoMethodUnknownOrigin new
]

{ #category : #accessing }
GtPharoMethodCoder >> methodReference [
	<return: #RGMethodDefinition or: nil>
	
	^ self compiledMethod ifNotNil: [ :aCompiledMethod |
			aCompiledMethod methodReference ]
]

{ #category : #'api - refactorings' }
GtPharoMethodCoder >> moveMethodToInstanceOrClass [
	| oldClass newClass model modelClass oldModelClass |
	oldClass := self behavior.
	newClass := oldClass isMeta
			ifTrue: [ oldClass soleInstance ]
			ifFalse: [ oldClass class ].
	(self isNewMethod or: [ self isModified ])
		ifTrue: [ self behavior: newClass.
			^ true ].
	self canMoveMethodToInstanceOrClass ifFalse: [ ^ false ].
	model := RBNamespace new.
	modelClass := model classFor: newClass.
	modelClass compile: self currentSourceString classified: self protocol.
	oldModelClass := model classFor: oldClass.
	(oldModelClass directlyDefinesMethod: self currentSelector)
		ifTrue: [ oldModelClass removeMethod: self currentSelector ].
	self behavior: newClass.
	[ model changes execute ] ifCurtailed: [ self behavior: oldClass ].
	^ true
]

{ #category : #'instance creation' }
GtPharoMethodCoder >> newEvaluationContext [
	^ GtPharoMethodCoderCompilationContext new
]

{ #category : #'private - actions' }
GtPharoMethodCoder >> newMethodSource [
	self
		deprecated: 'Use #currentSourceString instead.'
		transformWith: '`@receiver newMethodSource' -> '`@receiver currentSourceString'.

	^ self currentSourceString
]

{ #category : #updating }
GtPharoMethodCoder >> newRbAST: aString [
	| ast |
	self isModified
		ifFalse: [ self compiledMethod ifNotNil: [ :m | ^ m ast ] ].
	ast := self parseMethod: aString.
	ast isParseError
		ifTrue: [ ^ ast ].
	ast doSemanticAnalysis.
	^ ast
]

{ #category : #'private - notifying' }
GtPharoMethodCoder >> notifyClassAdded [
	self announce: (GtCoderClassAdded new coder: self)
]

{ #category : #'private - notifying' }
GtPharoMethodCoder >> notifyClassRemoved [
	self announce: (GtCoderClassRemoved new coder: self)
]

{ #category : #'private - notifying' }
GtPharoMethodCoder >> notifyClassRenamed [
	self announce: (GtCoderClassRenamed new coder: self)
]

{ #category : #'private - notifying' }
GtPharoMethodCoder >> notifyMethodAdded [
	self announce: (GtCoderMethodAdded new coder: self)
]

{ #category : #'private - notifying' }
GtPharoMethodCoder >> notifyMethodModified [
	self announce: (GtCoderMethodModified new coder: self)
]

{ #category : #'private - notifying' }
GtPharoMethodCoder >> notifyMethodRecompiledFrom: aPreviousCompiledMethod to: aNewCompiledMethod [
	self announce: (GtPharoMethodCoderCompiled new 
		methodCoder: self;
		previousMethod: aPreviousCompiledMethod; 
		newMethod: aNewCompiledMethod)
]

{ #category : #'private - notifying' }
GtPharoMethodCoder >> notifyMethodRemoved [
	self announce: (GtCoderMethodRemoved new coder: self)
]

{ #category : #accessing }
GtPharoMethodCoder >> object [
	self deprecated: 'Use GtPharoSourceCoderViewModel>>#selfObject instead'.

	^ UndefinedObject
]

{ #category : #'event handling' }
GtPharoMethodCoder >> onClassAdded: aClassAddedAnnouncement [
	(self methodBehavior affectedByClassAdded: aClassAddedAnnouncement)
		ifFalse: [ ^ self ].

	self methodBehavior: (self methodBehavior affectByClassAdded: aClassAddedAnnouncement).
	self notifyClassAdded
]

{ #category : #'event handling' }
GtPharoMethodCoder >> onClassRemoved: aClassRemovedAnnouncement [
	(self methodBehavior affectedByClassRemoved: aClassRemovedAnnouncement)
		ifFalse: [ ^ self ].
		
	self methodBehavior: (self methodBehavior affectByClassRemoved: aClassRemovedAnnouncement).
	self notifyClassRemoved
]

{ #category : #'event handling' }
GtPharoMethodCoder >> onClassRenamed: aClassRenamedAnnouncement [
	(self methodBehavior affectedByClassRenamed: aClassRenamedAnnouncement)
		ifFalse: [ ^ self ].

	self methodBehavior: (self methodBehavior affectByClassRenamed: aClassRenamedAnnouncement).
	self notifyClassRenamed
]

{ #category : #'event handling' }
GtPharoMethodCoder >> onMethodAdded: aMethodAddedAnnouncement [

	(aMethodAddedAnnouncement methodAdded methodClass = self behavior
		and: [ aMethodAddedAnnouncement methodAdded selector = self selector ])
			ifFalse: [ ^ self ].

	self isModified
		ifFalse: [ self forMethod: aMethodAddedAnnouncement methodAdded ]
		ifTrue: [ self sourceCode: (self sourceCode asCompiledMethodSourceCode: aMethodAddedAnnouncement methodAdded) ].

	self notifyMethodAdded
]

{ #category : #'event handling' }
GtPharoMethodCoder >> onMethodModified: aMethodModified [
	| doesAffect |

	doesAffect := self methodBehavior
		realBehaviorDo: [ :aBehavior |
			aMethodModified classAffected = aBehavior
				and: [ aMethodModified oldMethod selector = self selector
					or: [ aMethodModified newMethod selector = self selector ] ] ]
		ifAbsent: [
			self methodBehavior
				behaviorNameDo: [ :aBehaviorName |
					aMethodModified classAffected name = aBehaviorName
						and: [ aMethodModified oldMethod selector = self selector
							or: [ aMethodModified newMethod selector = self selector ] ] ]
			ifAbsent: [ false ] ].

	doesAffect
		ifFalse: [ ^ self ].

	self isModified
		ifFalse: [ self forMethod: aMethodModified newMethod ]
		ifTrue: [ self sourceCode: (self sourceCode asCompiledMethodSourceCode: aMethodModified newMethod) ].

	self notifyMethodModified
]

{ #category : #'event handling' }
GtPharoMethodCoder >> onMethodRemoved: aMethodRemovedAnnouncement [

	(aMethodRemovedAnnouncement methodRemoved methodClass = self behavior
		and: [ aMethodRemovedAnnouncement methodRemoved selector = self selector ])
			ifFalse: [ ^ self ].

	self notifyMethodRemoved
]

{ #category : #accessing }
GtPharoMethodCoder >> package [
	^ super package
		ifNil: [ self compiledMethod
				ifNil: [ self behavior ifNotNil: [ :cls | cls package ] ]
				ifNotNil: [ :method | method package ] ]
]

{ #category : #accessing }
GtPharoMethodCoder >> packageTag [
	^ super packageTag
		ifNil: [ self compiledMethod
				ifNotNil: [ :method | 
					method isExtension
						ifFalse: [ self package
								ifNotNil: [ :package | 
									| cls |
									cls := self behavior.
									cls category asString = package name asString
										ifFalse: [ package tagOrNilOf: cls ] ] ] ] ]
]

{ #category : #private }
GtPharoMethodCoder >> performMethodRefactoring: refactoring [
	[ refactoring primitiveExecute ]
		on: RBRefactoringError
		do: [ :ex | ^ false ].
	(self changedSourceForCurrentMethod: refactoring model changes)
		ifNotNil: [ :source | 
			self currentSourceString: source.
			^ true ].
	^ false
]

{ #category : #'api - actions' }
GtPharoMethodCoder >> playAllAndInspectInContext: aGtPharoSourceCoderEvaluationContext [
	"Save and execute a method"

	self isModified ifTrue: [ self save ifFalse: [ ^ self ] ].

	^ self
		evaluateSelector: self selector
		inContext: aGtPharoSourceCoderEvaluationContext
		thenDo: [ :anEvaluationResult | 
			self
				notifyObjectSpawnFromEvaluationResult: anEvaluationResult
				requesterObject: aGtPharoSourceCoderEvaluationContext requesterObject ]
]

{ #category : #'api - actions' }
GtPharoMethodCoder >> playAllInContext: aGtPharoSourceCoderEvaluationContext [
	self isModified
		ifTrue: [
			self save
				ifFalse: [ ^ self ] ].

	^ self
		evaluateSelector: self selector
		inContext: aGtPharoSourceCoderEvaluationContext
		thenDo: [ :aResult | ]
]

{ #category : #'api - actions examples' }
GtPharoMethodCoder >> playAndInspectExampleWithRequesterObject: aRequester [
	self playExample.
	self exampleResult
		ifNotNil: [ :anExampleResult | self notifyObjectSpawn: anExampleResult returnValue requesterObject: aRequester ]
]

{ #category : #'api - actions examples' }
GtPharoMethodCoder >> playAndInspectSlideWithRequesterObject: aRequester [
	self isModified ifTrue: [ self save ifFalse: [ ^ self ] ].

	self notifyObjectSpawn: self compiledMethod gtSlide requesterObject: aRequester
]

{ #category : #'api - actions examples' }
GtPharoMethodCoder >> playExample [
	self isModified
		ifTrue: [
			self save
				ifFalse: [ ^ self ] ].

	self example run
]

{ #category : #'gt-extensions' }
GtPharoMethodCoder >> previewElement [
	"Return a preview element for the Spotter"
	<return: #BlElement>

	^ (self class forClass: self behavior source: self currentSourceString)
		expanded: true;
		asElement
]

{ #category : #accessing }
GtPharoMethodCoder >> primitiveCompile: aSourceString inContext: aGtPharoSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	| isForMethod |
	isForMethod := self isForMethod
			and: [ aGtPharoSourceCoderEvaluationContext evaluatedInterval
					= (1 to: aGtPharoSourceCoderEvaluationContext sourceString size) ].
	isForMethod
		ifTrue: [ self isModified
				ifFalse: [ self compiledMethod ifNotNil: [ :method | ^ method ] ] ].
	^ super
		primitiveCompile: aSourceString
		inContext: aGtPharoSourceCoderEvaluationContext
		onFailDo: anEvaluationFailBlock
]

{ #category : #printing }
GtPharoMethodCoder >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self behavior asString;
		nextPutAll: '>>#';
		nextPutAll: self selector asString;
		nextPut: $)
]

{ #category : #'api - accessing' }
GtPharoMethodCoder >> protocol [
	"Ideally, it would return a protocol object
	and #protocolName a protocol name string."

	<return: #String or: nil>
	^ self protocolName
]

{ #category : #'api - accessing' }
GtPharoMethodCoder >> protocol: aSymbol [
	aSymbol
		ifNil: [ self removeAttributeNamed: #category ]
		ifNotNil: [ self attributeNamed: #category put: aSymbol ].
	self
		announce: (GtCoderProtocolChanged new
				newProtocol: aSymbol;
				coder: self;
				yourself)
]

{ #category : #'api - accessing' }
GtPharoMethodCoder >> protocolName [
	<return: #String or: nil>

	^ self
		attributeNamed: #category
		ifAbsent: [
			(self behavior notNil and: [ self selector notNil ])
				ifTrue: [ 
					self 
						forPharo12AndNewer: [
							self behavior protocolNameOfSelector: self selector] 
						forPharo11: [
							self behavior whichCategoryIncludesSelector: self selector ] ] ]
]

{ #category : #'api - actions' }
GtPharoMethodCoder >> remove [
	self coders
		ifNotNil: [ :theCoders | theCoders removeCoder: self ].

	self announcer
		suppress: GtCoderMethodRemoved
		during: [ self methodBehavior realBehaviorDo: [ :aBehavior |
				GtPharoCodeModifier current
					removeMethodFrom: aBehavior selector: self selector ] ].

	self reset.
	
	self notifyMethodRemoved
]

{ #category : #'api - refactorings' }
GtPharoMethodCoder >> renameProtocol: aString [
	| change |
	self protocol: aString asSymbol.
	selector notNil
		ifTrue: [ change := RBMethodProtocolChange
				selector: selector
				in: self behavior
				classified: self protocol.
			change execute ]
]

{ #category : #initialize }
GtPharoMethodCoder >> reset [
	super reset.

	self methodBehavior: GtPharoCoderBehavior unspecified.
	selector := nil.
	self protocol: nil
]

{ #category : #'private - refactorings' }
GtPharoMethodCoder >> safeTemporaryName [
	| name index found ast |
	name := '_'.
	index := 0.
	ast := self rbAST.
	[ found := false.
	ast
		nodesDo: [ :each | 
			(each defines: name)
				ifTrue: [ found := true ] ].
	found
		or: [ (self behavior allInstVarNames includes: name)
				or: [ self behavior allClassVarNames includes: name asSymbol ] ] ]
		whileTrue: [ name := 't' , index printString.
			index := index + 1 ].
	^ name
]

{ #category : #'api - actions' }
GtPharoMethodCoder >> save [
	"Try to save the current method validating syntax and return `true` if save was succesful, false otherwise"
	<return: #Boolean>

	^ self saveInContext: self evaluationContext
]

{ #category : #'api - actions' }
GtPharoMethodCoder >> saveInContext: aGtPharoSourceCoderEvaluationContext [
	"Try to save the current method validating syntax and return `true` if save was succesful, false otherwise"
	<return: #Boolean>

	(self validateSyntaxInContext: aGtPharoSourceCoderEvaluationContext)
		ifFalse: [ ^ false ].

	(self compileInContext: aGtPharoSourceCoderEvaluationContext)
		ifFalse: [ ^ false ].

	^ true
]

{ #category : #accessing }
GtPharoMethodCoder >> selector [
	"Assign an original selector which changes when the compiled method is assigned.
	The selector of the new method is undefined (nil).
	See #currentSelector if you need to take the source code into account"
	<return: #Symbol or: nil>

	^ selector
]

{ #category : #accessing }
GtPharoMethodCoder >> selector: aSymbol [
	selector := aSymbol
]

{ #category : #private }
GtPharoMethodCoder >> skipBlankLinesIn: source at: startIndex [
	| char index |
	index := startIndex.
	[ index <= source size and: [ (char := source at: index) = Character cr or: [ char = Character lf ] ] ]
		whileTrue: [ index := index + 1 ].
	^ index
]

{ #category : #'api - accessing' }
GtPharoMethodCoder >> sourceCode: aGtCoderSourceCode withStrategy: anUpdateStragegy [
	self clearExample.
	self clearTestCase.
	super sourceCode: aGtCoderSourceCode withStrategy: anUpdateStragegy
]

{ #category : #'api - ast' }
GtPharoMethodCoder >> startingStateForAstComputation [
	^ GtPharoParser startingStateForMethod
]

{ #category : #'private - subscriptions' }
GtPharoMethodCoder >> subscribeToSystem [
	self unsubscribeFromSystem.

	SystemAnnouncer uniqueInstance weak
		when: ClassAdded send: #onClassAdded: to: self;
		when: ClassRenamed send: #onClassRenamed: to: self;
		when: ClassRemoved send: #onClassRemoved: to: self;
		when: MethodAdded send: #onMethodAdded: to: self;
		when: MethodRemoved send: #onMethodRemoved: to: self;
		when: MethodModified send: #onMethodModified: to: self
]

{ #category : #'api - accessing' }
GtPharoMethodCoder >> traitSource [
	^ self compiledMethod 
		ifNotNil: [ :aMethod | aMethod traitSource ] 
		ifNil: [ nil ]
]

{ #category : #'private - subscriptions' }
GtPharoMethodCoder >> unsubscribeFromExample [
	self
		attributeNamed: #example
		ifPresent: [ :anOldExampleWithResult | anOldExampleWithResult announcer unsubscribe: self ]
		ifAbsent: [ "do nothing" ].
]

{ #category : #'private - subscriptions' }
GtPharoMethodCoder >> unsubscribeFromSystem [
	SystemAnnouncer uniqueInstance unsubscribe: self
]
