Class {
	#name : #GtPharoMethodCoderPromised,
	#superclass : #GtPharoSourceCoderPromised,
	#instVars : [
		'methodBehavior',
		'selector'
	],
	#classVars : [
		'NodeHighlight'
	],
	#category : #'GToolkit-Pharo-Coder-Promised'
}

{ #category : #'instance creation' }
GtPharoMethodCoderPromised class >> forClass: aBehavior source: aString [
	^ self new
		forClass: aBehavior source: aString;
		yourself
]

{ #category : #'instance creation' }
GtPharoMethodCoderPromised class >> forExample: anExample [
	^ self new
		forExample: anExample;
		yourself
]

{ #category : #'instance creation' }
GtPharoMethodCoderPromised class >> forMethod: aCompiledMethod [
	^ self new
		forMethod: aCompiledMethod;
		yourself
]

{ #category : #'instance creation' }
GtPharoMethodCoderPromised class >> forNewMethod: aBehavior [
	^ self forClass: aBehavior source: ''
]

{ #category : #'instance creation' }
GtPharoMethodCoderPromised class >> forObject: anObject andSelector: aSymbol [
	^ self forMethod: anObject class >> aSymbol
]

{ #category : #accessing }
GtPharoMethodCoderPromised class >> nodeHighlight [
	^ NodeHighlight
		ifNil: [ NodeHighlight := BlTextHighlightAttribute new
				paint: BrGlamorousColors textHighlightColor ]
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> addAddParameterRefactoringFor: aNode to: coderAddOns [
	| method valueNode |
	(aNode isMethod or: [ aNode isMethodPattern or: [ aNode parent isMethodPattern ] ])
		ifFalse:
			[ aNode isMessage ifTrue: [ valueNode := aNode parent ] ifFalse: [ aNode isValueNode ifTrue: [ valueNode := aNode ] ].
			[ valueNode notNil and: [ valueNode parent isKindOf: GtPharoLiteralNode ] ] whileTrue: [ valueNode := valueNode parent ].
			(valueNode isNil or: [ valueNode isVariableDefinition ]) ifTrue: [ ^ self ] ].
	method := aNode topParent.
	method selector isBinary ifTrue: [ ^ self ].
	coderAddOns
		addContextMenuItem: (self createLabel: 'Add parameter' description: method selector)
		hover: (valueNode ifNotNil: [ self highlightNodeBlock: valueNode ])
		leave: self removeHighlightBlock
		action:
			[ :aCoderViewModel | 
			((GtAddParameterRefactoringController new)
				sourceCoderViewModel: aCoderViewModel;
				parameterNode: valueNode;
				methodNode: method) execute ]
		id: #'context-menu--add-parameter'
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> addClassAccessorRefactoringsFor: aNode to: coderAddOns [
	aNode isVariable
		ifFalse: [ ^ self ].
	(aNode whoDefines) notNil
		ifTrue: [ ^ self ].
	(self behavior allClassVarNames includes: aNode variableName)
		ifFalse: [ ^ self ].
	coderAddOns
		addContextMenuItem: (self createLabel: 'Abstract variable' description: aNode variableName)
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel |
			(GtAbstractClassVariableRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				variableNode: aNode) execute ]
		id: #'context-menu--abstract-variable'.
	(self isAccessorMethodFor: aNode)
		ifFalse: [
			coderAddOns
				addContextMenuItem: (self createLabel: 'Create accessors' description: aNode variableName)
				hover: (self highlightNodeBlock: aNode)
				leave: self removeHighlightBlock
				action: [ :aCoderViewModel |
					(GtCreateClassVariableAccessorsRefactoringController new
						sourceCoderViewModel: aCoderViewModel;
						variableNode: aNode) execute ]
				id: #'context-menu--create-accessors' ]
]

{ #category : #'api - refactorings' }
GtPharoMethodCoderPromised >> addClassVariable: aString [
	| refactoring |
	refactoring := RBAddClassVariableRefactoring
		variable: aString
		class: self behavior instanceSide.
	refactoring execute.

	"Need to reset AST for undeclared variables"
	self resetASTCache.

	"and restyle the text"
	self requestStyleSourceText
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> addConvertTemporaryToInstanceVariableFor: aNode to: coderAddOns [
	aNode isVariable ifFalse: [ ^ self ].
	(aNode parent isSequence and: [ 
		 aNode parent variables identityIncludes: aNode ]) ifFalse: [ 
		^ self ].
	coderAddOns
		addContextMenuItem: (self
				 createLabel: 'Convert to instance variable'
				 description: aNode variableName)
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel |
			(GtConvertToInstanceVariableRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				variableNode: aNode) execute ]
		id: #'context-menu--convert-temp-to-inst-var'
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> addExtractMethodTo: coderAddOns from: aCoderViewModel [
	| theNodes |
	theNodes := self extractableNodesFrom: aCoderViewModel.
	theNodes
		ifNotEmpty: [
			(theNodes anySatisfy: [ :each | 
				 each isMethod or: [ (each nodeOfType: GtPharoMethodPatternNode) notNil ] ]) 
				ifTrue: [ ^ self ].
			coderAddOns
				addContextMenuItem: 'Extract method'
				hover: [ :textualCoderViewModel | 
					textualCoderViewModel
						addTextAttribute: self class nodeHighlight
						from: theNodes first startPosition
						to: theNodes last stopPosition ]
				leave: self removeHighlightBlock
				action: [ :aTextualViewModel | (GtExtractMethodController new sourceCoderViewModel: aTextualViewModel) execute ]
				id: GtMethodCoderExtractMethodContextMenuItemId ]
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> addExtractTempFor: aNode to: coderAddOns [
	(aNode isValueNode and: [ aNode isVariable not ])
		ifFalse: [ ^ self ].

	coderAddOns
		addContextMenuItem:
			(self
				createLabel: 'Extract temporary'
				description: (self nodeDescription: aNode))
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel | self extractTemporaryVariable: aNode in: aCoderViewModel ]
		id: #'context-menu--extract-temp'
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> addInlineAllSelfSendsFor: aNode to: coderAddOns [
	| method |
	(aNode isMethod or: [ 
		 aNode isMethodPattern or: [ aNode parent isMethodPattern ] ]) 
		ifFalse: [ ^ self ].
	method := aNode topParent.
	coderAddOns
		addContextMenuItem: (self
				 createLabel: 'Inline All self Sends'
				 description: method selector)
		hover: nil
		leave: nil
		action: [ :aSourceCoderViewModel | 
			(GtInlineSelfSendsRefactoringController new
				 methodNode: method;
				 sourceCoderViewModel: aSourceCoderViewModel) execute ]
		id: #'context-menu--inline-self-sends'
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> addInlineSelfMessageFor: aNode to: coderAddOns [
	aNode isMessageSend
		ifFalse: [ ^ self ].
	aNode receiver isSelf
		ifFalse: [ ^ self ].
	coderAddOns
		addContextMenuItem: (self createLabel: 'Inline Message' description: aNode message selector)
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aSourceCoderViewModel |
			(GtMethodInlineMessageSendRefactoringController new
				node: aNode;
				sourceCoderViewModel: aSourceCoderViewModel) execute ]
		id: #'context-menu--inline-message'
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> addInlineTempFor: aNode to: coderAddOns [
	aNode isAssignment
		ifFalse: [ ^ self ].
	aNode variable whoDefines
		ifNil: [ ^ self ].
	
	coderAddOns
		addContextMenuItem: (self createLabel: 'Inline Assignment' description: aNode variable variableName)
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aSourceCoderViewModel |
			(GtMethodInlineTemporaryVariableRefactoringController new
				node: aNode;
				sourceCoderViewModel: aSourceCoderViewModel) execute ]
		id: #'context-menu--inline-temp'
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> addInstanceAccessorRefactoringsFor: aNode to: coderAddOns [
	aNode isVariable
		ifFalse: [ ^ self ].

	(aNode whoDefines: aNode variableName) notNil
		ifTrue: [ ^ self ].

	(self behavior allInstVarNames includes: aNode variableName)
		ifFalse: [ ^ self ].

	coderAddOns
		addContextMenuItem: (self createLabel: 'Abstract variable' description: aNode variableName)
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel |
			(GtAbstractInstanceVariableRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				variableNode: aNode) execute ]
		id: #'context-menu--abstract-variable'.
	(self isAccessorMethodFor: aNode)
		ifTrue: [ coderAddOns
				addContextMenuItem: (self createLabel: 'Protect variable' description: aNode variableName)
				hover: (self highlightNodeBlock: aNode)
				leave: self removeHighlightBlock
				action: [ :aCoderViewModel |
					(GtProtectInstanceVariableRefactoringController new
						sourceCoderViewModel: aCoderViewModel;
						variableNode: aNode) execute ]
				id: #'context-menu--protect-variable' ]
		ifFalse: [ coderAddOns
				addContextMenuItem: (self createLabel: 'Create accessors' description: aNode variableName)
				hover: (self highlightNodeBlock: aNode)
				leave: self removeHighlightBlock
				action: [ :aCoderViewModel |
					(GtCreateInstanceVariableAccessorsRefactoringController new
						sourceCoderViewModel: aCoderViewModel;
						variableNode: aNode) execute ]
				id: #'context-menu--create-accessors' ]
]

{ #category : #'api - refactorings' }
GtPharoMethodCoderPromised >> addInstanceVariable: aString [
	| refactoring |
	refactoring := RBAddInstanceVariableRefactoring
		variable: aString
		class: self behavior.
	refactoring execute.
	self resetASTCache.	"Need to reset AST for undeclared variables"
	self requestStyleSourceText
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> addPullDownVariableRefactoringsFor: aNode to: coderAddOns [
	| class |
	aNode isVariable
		ifFalse: [ ^ self ].

	aNode whoDefines notNil
		ifTrue: [ ^ self ].
	
	class := self behavior whichClassDefinesInstVar: aNode variableName.
	(class isNil or: [ class = self behavior ])
		ifTrue: [ ^ self ].

	coderAddOns
		addContextMenuItem: (self createLabel: 'Pull down variable declaration' description: aNode variableName)
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel |
			(GtPushDownInstanceVariableRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				variableNode: aNode) execute ]
		id: #'context-menu--pull-down-variable'
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> addPushDownMethodRefactoringFor: aNode to: coderAddOns [
	| method |
	(aNode isMethod or: [ aNode isMethodPattern or: [ aNode parent isMethodPattern ] ]) 
		ifFalse: [ ^ self ].
	self behavior subclasses isEmpty ifTrue: [ ^ self ].
	method := aNode topParent.
	(self behavior subclasses allSatisfy: [ :each | each includesSelector: method selector ])
		ifTrue: [ ^ self ].
	coderAddOns
		addContextMenuItem:
			(self
				 createLabel: 'Push down method'
				 description: aNode selector)
		hover: nil
		leave: nil
		action: [ :aCoderViewModel | 
			(GtPushDownMethodRefactoringController new
				 sourceCoderViewModel: aCoderViewModel;
				 methodNode: method) execute ]
		id: #'context-menu--push-down-method'
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> addPushUpMethodRefactoringFor: aNode to: coderAddOns [
	| method variables |
	(aNode isMethod or: [ aNode isMethodPattern or: [ aNode parent isMethodPattern ] ]) 
		ifFalse: [ ^ self ].
	self behavior superclass isNil ifTrue: [ ^ self ].
	variables := Set withAll: self behavior instVarNames.
	variables addAll: self behavior classVarNames.
	method := aNode topParent.
	method
		allNodesOfType: GtPharoVariableNode
		do: [ :each | (variables includes: each variableName) ifTrue: [ ^ self ] ].
	coderAddOns
		addContextMenuItem:
			(self
				 createLabel: 'Push up method'
				 description: aNode selector)
		hover: nil
		leave: nil
		action: [ :aCoderViewModel | 
			(GtPushUpMethodRefactoringController new
				 sourceCoderViewModel: aCoderViewModel;
				 methodNode: method) execute ]
		id: #'context-menu--push-up-method'
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> addPushUpVariableRefactoringsFor: aNode to: coderAddOns [
	aNode isVariable
		ifFalse: [ ^ self ].

	aNode whoDefines notNil
		ifTrue: [ ^ self ].

	(self behavior allInstVarNames includes: aNode variableName)
		ifFalse: [ ^ self ].
	
	(self behavior whichClassDefinesInstVar: aNode variableName) superclass = Object 
		ifTrue: [ ^self ].

	coderAddOns
		addContextMenuItem: (self createLabel: 'Push up variable declaration' description: aNode variableName)
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel |
			(GtPushUpInstanceVariableRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				variableNode: aNode) execute ]
		id: #'context-menu--push-up-variable'
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> addRefactoringContextMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 20>
	
	self addExtractMethodTo: coderAddOns from: aCoderViewModel.
	
	(self extractableNodesFrom: aCoderViewModel)
		ifNotEmpty: [ :theNodes | 
			| aNode |
			
			aNode := theNodes first.
			
			self addPushUpMethodRefactoringFor: aNode to: coderAddOns.
			self addPushDownMethodRefactoringFor: aNode to: coderAddOns.
			self addAddParameterRefactoringFor: aNode to: coderAddOns.
			self addInlineAllSelfSendsFor: aNode to: coderAddOns.
			self addInstanceAccessorRefactoringsFor: aNode to: coderAddOns.
			self addPushUpVariableRefactoringsFor: aNode to: coderAddOns.
			self addPullDownVariableRefactoringsFor: aNode to: coderAddOns.
			self addClassAccessorRefactoringsFor: aNode to: coderAddOns.
			self addRemoveParameterRefactoringFor: aNode to: coderAddOns.
			self addConvertTemporaryToInstanceVariableFor: aNode to: coderAddOns. 
			self addVariableScopingFor: aNode to: coderAddOns.
			aNode
				withAllParentsDo: [ :node | self addInlineSelfMessageFor: node to: coderAddOns ].
			aNode
				withAllParentsDo: [ :node | self addInlineTempFor: node to: coderAddOns ].
			aNode
				withAllParentsDo: [ :node | self addExtractTempFor: node to: coderAddOns ] ]
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> addRemoveParameterRefactoringFor: aNode to: coderAddOns [
	aNode isVariable
		ifFalse: [ ^ self ].
	aNode parent isMethodPattern
		ifFalse: [ ^ self ].
	aNode parent parent body
		allNodesDo: [ :each | 
			each = aNode
				ifTrue: [ ^ self ] ].
	coderAddOns
		addContextMenuItem: (self createLabel: 'Remove parameter' description: aNode variableName)
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel |
			(GtRemoveParameterRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				variableNode: aNode) execute ]
		id: #'context-menu--remove-parameter'
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> addVariableScopingFor: aNode to: coderAddOns [
	| uses groups |
	aNode isVariable ifFalse: [ ^ self ].
	(aNode parent isSequence and: [ 
		 aNode parent variables identityIncludes: aNode ]) ifFalse: [ 
		^ self ].
	uses := OrderedCollection new.
	aNode parent statements do: [ :each | 
		each allNodesOfType: GtPharoVariableNode do: [ :var | 
			var = aNode ifTrue: [ 
				(var parentOfType: GtPharoBlockNode)
					ifNil: [ ^ self ]
					ifNotNil: [ :block | 
						block == (aNode parentOfType: GtPharoBlockNode) ifTrue: [ 
							^ self ] ].
				uses add: var ] ] ].
	groups := uses groupedBy: [ :each | 
		          | parents block |
		          parents := each allParents.
		          1 to: (parents identityIndexOf: aNode parent) - 1 do: [ :i | 
			          ((parents at: i) isKindOf: GtPharoBlockNode) ifTrue: [ 
				          block := parents at: i ] ].
		          block ].
	groups do: [ :each | each first isAssignedTo ifFalse: [ ^ self ] ].
	coderAddOns
		addContextMenuItem: (self
				 createLabel: 'Move declaration to inner scope'
				 description: aNode variableName)
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aSourceCoderViewModel | 
			(GtMoveVariableRefactoringController new
				 variableNode: aNode;
				 sourceCoderViewModel: aSourceCoderViewModel) execute ]
		id: #'context-menu--move-variable-declaration'
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> asCoderUIModel [
	^ GtPharoMethodCoderViewModel new coder: self
]

{ #category : #converting }
GtPharoMethodCoderPromised >> asCoderViewModel [
	^ GtPharoMethodCoderViewModelPromised new coder: self
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> baselineAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 10>

	(self behavior inheritsFrom: BaselineOf)
		ifFalse: [ ^ self ].

	coderAddOns addStyler: GtCoderExpandableBaselineStyler new
]

{ #category : #'api - accessing' }
GtPharoMethodCoderPromised >> behavior [
	<return: #Behavior>

	"self methodBehavior isClass
		ifTrue: [ ^ self methodBehavior ].

	self methodBehavior realBehaviorDo: [ :aBehavior | ^ aBehavior ].
	^ UndefinedObject"

	^ self behaviorPromise wait
]

{ #category : #'api - accessing' }
GtPharoMethodCoderPromised >> behavior: aBehavior [
	self methodBehavior: (GtPharoCoderBehavior explicit: aBehavior)
]

{ #category : #'api - accessing' }
GtPharoMethodCoderPromised >> behaviorPromise [
	<return: #Behavior>

	"self methodBehavior isClass
		ifTrue: [ ^ self methodBehavior ].

	self methodBehavior realBehaviorDo: [ :aBehavior | ^ aBehavior ].
	^ UndefinedObject"
	^ nil
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> breadcrumbActions [
	<return: #Array of: #GtSourceCoderBreadcrumbAction>
	^ Array
		streamContents: [ :aStream | 
			(self compiledMethod ifNil: [ self behavior ]) package
				ifNotNil: [ :aPackage | 
					aStream
						nextPut: (GtSourceCoderBreadcrumbSpawnPackageAction new package: aPackage) ].
			aStream nextPut: (GtSourceCoderBreadcrumbSpawnBehaviorAction new methodBehavior: self methodBehavior) ]
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> browseFrom: anEditorElement [ 
	((GtCoder forMethod: self compiledMethod)
		openInPagerFrom: anEditorElement)
			maximized
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> buildRemoveMethodLabel: anElement [
	| references element labelText |
	(self isNewMethod
		or: [ selector isNil
				or: [ (references := self selector gtReferences) isEmpty ] ])
		ifTrue: [ ^ BrLabel new
				margin: (BlInsets all: 10);
				aptitude: BrGlamorousLabelAptitude new glamorousRegularFont;
				text: 'Remove method?' asRopedText ].
	labelText := selector asRopedText glamorousCodeFontAndSize bold.
	labelText
		append: ' is still referenced in ' asRopedText glamorousRegularFontAndSize.
	element := BlElement new
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ].
	element
		addChild:
			(BrLabel new
				margin:
					(BlInsets
						top: 10
						left: 10
						bottom: 10
						right: 0);
				aptitude: BrGlamorousLabelAptitude new;
				text: labelText).
	(labelText from: 1 to: selector size)
		attributes:
			{(BlFontFamilyAttribute named: 'Source Code Pro')
				beNotOverwritableByStyler}.
	element
		addChild:
			(BrButton new
				aptitude: BrGlamorousLinkSquaredButtonWithLabelAptitude new;
				beSmallSize;
				margin: (BlInsets top: 10 left: 2 bottom: 10 right: 10);
				label:
					(references size printString , ' method'
						,
							(references size = 1
								ifTrue: [ '' ]
								ifFalse: [ 's' ])) asRopedText glamorousRegularFontAndSize;
				action: [ anElement phlow spawnObject: references ]).
	^ element
]

{ #category : #testing }
GtPharoMethodCoderPromised >> canCompileMethodIn: newClass [
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
GtPharoMethodCoderPromised >> canExecuteExample [
	<return: #Boolean>

	^ self example
		ifNil: [ false ]
		ifNotNil: [ :anExample | anExample canBeExecuted ]
]

{ #category : #testing }
GtPharoMethodCoderPromised >> canMoveMethodToInstanceOrClass [
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
GtPharoMethodCoderPromised >> category [
	self
		deprecated: 'Use #protocol instead.'
		transformWith: '`@receiver category' -> '`@receiver protocol'.

	^ self protocol
]

{ #category : #'api - accessing' }
GtPharoMethodCoderPromised >> category: aSymbol [
	self
		deprecated: 'Use #protocol: instead.'
		transformWith: '`@receiver category: `@arg' -> '`@receiver protocol: `@arg'.

	self protocol: aSymbol
]

{ #category : #'private - actions' }
GtPharoMethodCoderPromised >> changeManager [
	^ RBRefactoryChangeManager instance
]

{ #category : #private }
GtPharoMethodCoderPromised >> changedSourceForCurrentMethod: aRefactoryChange [
	aRefactoryChange changes
		reverseDo: [ :each | 
			((each isKindOf: RBAddMethodChange)
				and: [ each selector = self currentSelector
						and: [ self behavior = each changeClass ] ])
				ifTrue: [ ^ each source ] ].
	^ nil
]

{ #category : #accessing }
GtPharoMethodCoderPromised >> classOrMetaClass: aBehavior [
	self
		deprecated: 'Use #behavior: instead.'
		transformWith: '`@receiver classOrMetaClass: `@arg' -> '`@receiver behavior: `@arg'.

	self behavior: aBehavior
]

{ #category : #'private - actions' }
GtPharoMethodCoderPromised >> clearExample [
	self unsubscribeFromExample.
	self removeAttributeNamed: #example.
]

{ #category : #'api - actions' }
GtPharoMethodCoderPromised >> compile [
	"Try to compile the current source code and return true if it was successful, false otherwise"
	<return: #Boolean>

	^ self compileInContext: self evaluationContext
]

{ #category : #'api - actions' }
GtPharoMethodCoderPromised >> compileInContext: aGtPharoSourceCoderEvaluationContext [
	"Try to compile the current source code and return true if it was successful, false otherwise"
	<return: #Boolean>

	"we should use #currentSelector instead of #selector because we care
	about the `current` state of the coder (#selector may be nil for new methods)"
	self currentSelector
		ifNil: [ ^ false ].

	^ self methodBehavior
		realBehaviorDo: [ :aBehavior |
			| aChange |
			aChange := self createCompileMethodChangeIn: aBehavior inContext: aGtPharoSourceCoderEvaluationContext.

			selector := aChange selector.

			(self
				handleCompilerErrorsDuring: [ GtPharoCodeModifier current performRefactoryChange: aChange ])
				ifFalse: [ ^ false ].

			aChange definedSelector
				ifNotNil: [ :sel | 
					self selector: sel.
					self compiledMethod
						ifNotNil: [ :method |
							self forMethod: method.
							^ true ] ].
			false ]
		ifAbsent: [ false ]
]

{ #category : #'api - accessing' }
GtPharoMethodCoderPromised >> compiledMethod [
	<return: #CompiledMethod or: nil>
	
	^ self existsInTheSystem
		ifTrue: [ self behavior >> self selector ]
		ifFalse: [ nil ]
]

{ #category : #'api - ast' }
GtPharoMethodCoderPromised >> computeAst: theSourceString [
	^ GtPharoParser
		parseWithErrors: theSourceString
		startingAt: GtPharoParser startingStateForMethod
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> copyMethodNameToClipboard [
	self compiledMethod ifNotNil: [ :aCompiledMethod | 
		Clipboard clipboardText: aCompiledMethod printString ]
]

{ #category : #private }
GtPharoMethodCoderPromised >> createCompileMethodChange [
	<return: #RBAddMethodChange or: nil>

	^ self methodBehavior
		realBehaviorDo: [ :aBehavior | self createCompileMethodChangeIn: aBehavior inContext: self evaluationContext ]
		ifAbsent: [ nil ]
]

{ #category : #private }
GtPharoMethodCoderPromised >> createCompileMethodChangeIn: aBehavior inContext: aGtPharoSourceCoderEvaluationContext [
	<return: #RBAddMethodChange>
	| aSourceString |
	
	aSourceString := self currentSourceString.

	aGtPharoSourceCoderEvaluationContext
		sourceString: aSourceString;
		evaluatedInterval: (1 to: aSourceString size);
		evaluatedSourceString: aSourceString.

	^ self protocol
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
				for: aGtPharoSourceCoderEvaluationContext ]
]

{ #category : #'private - refactorings' }
GtPharoMethodCoderPromised >> createLabel: aString description: description [
	^ aString asRopedText
		,
			((' ' , description) asRopedText
				attributes:
					{(BlFontSizeAttribute size: 12).
					(BlTextForegroundAttribute paint: Color gray)})
]

{ #category : #private }
GtPharoMethodCoderPromised >> createRefactoringModel [
	| model |
	model := RBClassModelFactory rbNamespace onEnvironment: RBBrowserEnvironment new.
	(((model classFor: self behavior) directlyDefinesMethod: self currentSelector) not
		or: [ ((model classFor: self behavior) sourceCodeFor: self currentSelector) ~= self sourceText asString ])
		ifTrue: [ (model classFor: self behavior) compile: self sourceText asString classified: self protocol ].
	^ model
]

{ #category : #accessing }
GtPharoMethodCoderPromised >> currentSelector [
	<return: #Symbol or: nil>
	| theAst |

	selector
		ifNotNil: [ ^ selector ].

	theAst := self astAwait.
	theAst
		ifNil: [ ^ nil ].
	
	theAst isMethod
		ifFalse: [ ^ #faulty ].
			
	theAst selectorDo: [ :aSymbol | ^ aSymbol ].

	^ #faulty
]

{ #category : #'api - actions examples' }
GtPharoMethodCoderPromised >> debugExample [
	self isModified
		ifTrue: [ self save
			ifFalse: [ ^ self ] ].
	self example openingDebugger result
]

{ #category : #'private - actions' }
GtPharoMethodCoderPromised >> evaluateSelector: aSymbol inContext: aGtPharoSourceCoderEvaluationContext thenDo: aThenBlock [
	"Evaluate a given source code and show the print string if needed"
	| aReceiver aSourceString aResult |

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

	aResult := self
		evaluateBlock: [ aReceiver perform: aSymbol ]
		onErrorDo: [ :aResultWithError | aResultWithError evaluationContext: aGtPharoSourceCoderEvaluationContext ].

	aResult evaluationContext: aGtPharoSourceCoderEvaluationContext.

	self notifyEvaluatedWithResult: aResult.
	aThenBlock cull: aResult.

	^ aResult
]

{ #category : #'api - actions examples' }
GtPharoMethodCoderPromised >> example [
	<return: #GtExampleWithResult or: nil>
	| anExample |
	anExample := self attributeNamed: #example.
	anExample ifNil: [ 
		anExample := self compiledMethod ifNotNil: [ :aCompiledMethod | 
			aCompiledMethod gtExample ifNotNil: #asExampleWithResult ].
		anExample ifNotNil: [ self example: anExample ] ].
	^ anExample
]

{ #category : #'api - actions examples' }
GtPharoMethodCoderPromised >> example: anExampleWithResult [
	| aCompiledMethod |
	self unsubscribeFromExample.
	self
		attributeNamed: #example
		put: anExampleWithResult asExampleWithResult.
	aCompiledMethod := anExampleWithResult method.
	(aCompiledMethod selector = self selector
		and: [ aCompiledMethod methodClass = self behavior ])
		ifFalse: [ self error: 'Can not assign example of the wrong method' ].
	self example announcer
		when: GtExampleExecuted send: #handleExampleExecuted: to: self;
		when: GtExampleArgumentsChanged
			send: #handleExampleArgumentsChanged:
			to: self
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> exampleAstFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 10>
	
	self compiledMethod
		ifNil: [ ^ self ].
	
	anAST methodNode
		ifNil: [ ^ self ].
		
	(anAST methodNode pragmas anySatisfy: [ :each | each isErrorNode not and: [ each selector = #gtExample ] ])
		ifFalse: [ ^ self ].

	coderAddOns addStyler: GtCoderExampleStatusStyler new.

	(self canExecuteExample or: [ anAST methodNode numArgs isZero ])
		ifFalse: [ ^ self ].

	coderAddOns
		addContextAction: 'Play Example' translated
		icon: BrGlamorousVectorIcons play
		action: [ :aCoderUIModel :anEvent | self playExample ]
		id: GtMethodCoderPlayExampleActionId.
	coderAddOns
		addContextAction: 'Play and Inspect Example Result' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anEvent | self playAndInspectExample ]
		id: GtMethodCoderPlayAndInspectExampleActionId.
	coderAddOns
		addContextAction: 'Inspect Example Object' translated
		icon: BrGlamorousVectorIcons eg
		action: [ :aCoderUIModel :anEvent | self notifyObjectSpawn: self example ].
	coderAddOns
		addContextAction: 'Debug Example' translated
		icon: BrGlamorousVectorIcons debug
		action: [ :aCoderUIModel :anEvent | self debugExample ]
		id: GtMethodCoderDebugExampleActionId
]

{ #category : #'api - actions examples' }
GtPharoMethodCoderPromised >> exampleResult [
	<return: #GtExampleResult or: nil>
	^ self example ifNotNil: #result
]

{ #category : #testing }
GtPharoMethodCoderPromised >> existsInTheSystem [
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

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> explanationFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 10>

	self explanationLink notNil
		ifTrue: [ coderAddOns addStyler: self explanationLink ].
]

{ #category : #accessing }
GtPharoMethodCoderPromised >> explanationLink [
	^ self attributeNamed: #explanationLink
]

{ #category : #accessing }
GtPharoMethodCoderPromised >> explanationLink: anExplanation [
	self explanationLink == anExplanation
		ifTrue: [ ^ self ].

	self attributeNamed: #explanationLink put: anExplanation.
	
	self requestStyleSourceText.
	self requestUpdateAddOns
]

{ #category : #'api - refactorings' }
GtPharoMethodCoderPromised >> extractTemporaryVariable: aNode in: aCoderViewModel [
	| refactoring model tempName |

	model := self createRefactoringModel.
	tempName := self safeTemporaryName.

	refactoring := RBExtractToTemporaryRefactoring
		model: model
		extract: aNode sourceInterval
		to: tempName
		from: self currentSelector
		in: (model classFor: self behavior).

	(self performMethodRefactoring: refactoring)
		ifFalse: [ ^ self ].

	(self findNodeAssigning: tempName)
		ifNotNil: [ :node | 
			aCoderViewModel
				selectNone;
				moveCursorTo: node stop;
				renameLocalVariableAt: node stop ]
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> extractableNodesFrom: aCoderViewModel [
	| allSelections allCursors |

	allSelections := aCoderViewModel selection allSelections.
	allCursors := aCoderViewModel cursors allCursors.

	^ allSelections size = 1
		ifTrue: [ self extractableNodesWithin: allSelections first interval ]
		ifFalse: [ allCursors size = 1
			ifTrue: [ self extractableNodesAt: allCursors first position ]
			ifFalse: [ #() ] ]
]

{ #category : #'private - refactorings' }
GtPharoMethodCoderPromised >> findNodeAssigning: aString [
	self rbAST
		nodesDo: [ :each | 
			(each isAssignment and: [ each variable name = aString ])
				ifTrue: [ ^ each variable ] ].
	^ nil
]

{ #category : #private }
GtPharoMethodCoderPromised >> findSeparatorBetweenPatternAndBodyIn: aMethodNode [
	| startIndex char source |
	source := aMethodNode completeSource.
	startIndex := aMethodNode pattern stopPosition + 1.
	[ startIndex <= source size and: [ (char := source at: startIndex) isSeparator and: [ char ~= Character cr ] ] ]
		whileTrue: [ startIndex := startIndex + 1 ].
	^ startIndex
]

{ #category : #initialize }
GtPharoMethodCoderPromised >> forClass: aBehavior source: aString [
	self behavior: aBehavior.
	self sourceCode: (GtCoderExplicitSourceCode new source: aString)
]

{ #category : #initialize }
GtPharoMethodCoderPromised >> forExample: anExampleWithResult [
	self forMethod: anExampleWithResult method.
	self example: anExampleWithResult
]

{ #category : #initialize }
GtPharoMethodCoderPromised >> forMethod: aCompiledMethod [
	self methodBehavior:(GtPharoCoderBehavior explicit: aCompiledMethod methodClass).
	self selector: aCompiledMethod selector.
	self sourceCode: (GtCoderCompiledMethodSourceCode new compiledMethod: aCompiledMethod).
	self protocol: aCompiledMethod category
]

{ #category : #'api - actions' }
GtPharoMethodCoderPromised >> format [
	| ast |
	ast := [ RBParser parseMethod: self currentSourceString ]
		on: SyntaxErrorNotification
		do: [ :ex | 
			^ self
				notifyParseError: ex errorMessage
				at: ex location ].
			
	self currentSourceString: ast formattedCode.
]

{ #category : #'gt-extensions' }
GtPharoMethodCoderPromised >> gtDiffViewFor: aView [
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

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> gtViewAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 6>
	(self hasObjectAttribute
		and: [ anAST notNil
				and: [ anAST methodNode
						ifNotNil: [ :node | 
							node arguments size = 1
								and: [ node pragmas
										anySatisfy:
											[ :each | each isParseError not and: [ each selector = #gtView ] ] ] ]
						ifNil: [ false ] ] ])
		ifFalse: [ ^ self ].

	coderAddOns
		addContextAction: 'gtView' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anEvent | self runGtViewFrom: anEvent currentTarget ]
]

{ #category : #private }
GtPharoMethodCoderPromised >> handleCompilerErrorsDuring: aBlock [
	^ [
			aBlock value.
			true ]
		on: OCSemanticWarning
		do: [ :ex | 
			self
				notifyParseError: ex errorMessage
				at: ex location.
			ex return: false ]
]

{ #category : #'examples - event handling' }
GtPharoMethodCoderPromised >> handleExampleArgumentsChanged: aGtExampleArgumentsChanged [
	self requestUpdateAddOns
]

{ #category : #'examples - event handling' }
GtPharoMethodCoderPromised >> handleExampleExecuted: aGtExampleExecuted [
	self requestStyleSourceText.
	self announce: (GtCoderExampleExecuted new 
		coder: self;
		example: aGtExampleExecuted example)
]

{ #category : #'private - refactorings' }
GtPharoMethodCoderPromised >> highlightNodeBlock: aNode [
	^ [ :textualCoderViewModel | 
	  textualCoderViewModel
		  addTextAttribute: self class nodeHighlight
		  from: aNode startPosition
		  to: aNode stopPosition ]
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> highlighter [
	<return: #GtSourceReferenceHighlighter>

	^ self attributeNamed: #highlighter
]

{ #category : #accessing }
GtPharoMethodCoderPromised >> highlighter: aGtSourceReferenceHighlighter [
	"Set a source reference highlighter thhat should be used tp highlight or mark some parts
	of the source code. If a given highlighter is nil, it means that no highlighter should be used"

	self highlighter == aGtSourceReferenceHighlighter
		ifTrue: [ ^ self ].

	self
		attributeNamed: #highlighter
		put: aGtSourceReferenceHighlighter.

	self requestUpdateAddOns.
	self requestStyleSourceText
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> highlighterFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 10>
	self highlighter notNil
		ifTrue: [ coderAddOns addStyler: self highlighter ]
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> initializeAddOns: addOns [
	super initializeAddOns: addOns.
	
	addOns addStyler: GtPharoStyler new.
	addOns addStyler: GtPharoDeprecationStyler new.
	addOns addStyler: GtPharoDynamicHighlightStyler new.
	addOns addStyler: GtPharoMethodExpanderStyler new.
	addOns addStyler: (GtFixItStyler new isForWorkspace: false).

	"addOns addStyler: GtCoderCommentStyler new."

	addOns
		addMainAction: (GtCoderActivatableAction new
			id: GtMethodCoderSaveActionId;
			title: 'Save' translated;
			icon: BrGlamorousVectorIcons accept;
			action: [ :aCoderUIModel :anEvent | aCoderUIModel save ];
			enabled: [ :aCoderUIModel | aCoderUIModel isSaveEnabled ];
			updateWhen: GtMethodCoderSaveAbilityChanged).
	addOns
		addDropDownWithPreviewAction: 'Remove' translated
		icon: BrGlamorousVectorIcons remove
		action: [ :aButtonElement :aButtonModel :anEvent | self remove ]
		stencil: [ :element | self buildRemoveMethodLabel: element ].
	addOns
		addMainAction: 'Browse' translated
		icon: BrGlamorousVectorIcons browse
		action: [ :aCoderUIModel :anElement | self browseFrom: anElement ].
	addOns
		addMainAction: 'Inspect Method' translated
		icon: BrGlamorousVectorIcons inspect
		action: [ :aCoderUIModel :anElement | self notifyObjectSpawn: aCoderUIModel compiledMethod ].
	addOns
		addMainAction: 'Copy Method Name' translated
		icon: BrGlamorousVectorIcons clipboard
		action: [ :aCoderUIModel :anElement | self copyMethodNameToClipboard ]
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> initializeShortcuts: addOns [
	super initializeShortcuts: addOns.

	addOns
		addShortcut: GtSourceCoderPlayShortcut new;
		addShortcut: GtSourceCoderPlayAndInspectShortcut new;
		addShortcut: GtSourceCoderExtractMethodShortcut new;
		addShortcut: GtSourceCoderSaveShortcut new;
		addShortcut: GtSourceCoderFormatShortcut new;
		addShortcut: GtSourceCoderInlineRenameShortcut new
]

{ #category : #'private - refactorings' }
GtPharoMethodCoderPromised >> isAccessorMethodFor: aNode [
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
GtPharoMethodCoderPromised >> isForMethod [
	^ true
]

{ #category : #testing }
GtPharoMethodCoderPromised >> isForMethod: aCompiledMethod [
	^ self behavior = aCompiledMethod methodClass
		and: [ self selector = aCompiledMethod selector ]
]

{ #category : #testing }
GtPharoMethodCoderPromised >> isFromTrait [
	^ self compiledMethod
		ifNil: [ false ]
		ifNotNil: [ :aMethod | aMethod isFromTrait ]
]

{ #category : #testing }
GtPharoMethodCoderPromised >> isMeta [
	"Return true if the method is implemented in the metaclass (~ class side)"
	<return: #Boolean>

	^ self behavior isMeta
]

{ #category : #'api - addons' }
GtPharoMethodCoderPromised >> isMondrianPaintMethod: aMethodNode [
	| variable |
	aMethodNode arguments size ~= 1
		ifTrue: [ ^ false ].
	('paint*With:' match: aMethodNode selector)
		ifFalse: [ ^ false ].
	variable := aMethodNode arguments first.
	aMethodNode
		nodesDo: [ :each | 
			(each isMessage and: [ each receiver = variable ])
				ifTrue: [ (GtMondrian canUnderstand: each selector)
						ifFalse: [ ^ false ] ] ].
	^ true
]

{ #category : #testing }
GtPharoMethodCoderPromised >> isNewMethod [
	^ self currentSourceString isEmpty
]

{ #category : #testing }
GtPharoMethodCoderPromised >> isOverridden [

	| sel |
	sel := self currentSelector.
	sel isNil ifTrue: [ ^ false ].
	self behavior allSubclassesDo: [ :cls | 
		(cls includesSelector: sel) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #testing }
GtPharoMethodCoderPromised >> isOverriding [

	| sel |
	sel := self currentSelector.
	^ sel notNil and: [ 
		  self behavior superclass
			  ifNil: [ false ]
			  ifNotNil: [ :spr | (spr whichClassIncludesSelector: sel) notNil ] ]
]

{ #category : #'api - accessing' }
GtPharoMethodCoderPromised >> methodBehavior [
	<return: #GtPharoCoderBehavior>

	^ methodBehavior
]

{ #category : #'api - accessing' }
GtPharoMethodCoderPromised >> methodBehavior: aGtMethodCoderBehavior [
	self
		assert: [ aGtMethodCoderBehavior isKindOf: GtPharoCoderBehavior ]
		description: [ 'Behavior must be reifined as an object' ].

	methodBehavior := aGtMethodCoderBehavior
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> modifiedMessageAstFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 1>

	self isModified
		ifFalse: [ ^ self ].

	coderAddOns
		addMainAction: 'Discard Changes' translated
		icon: BrGlamorousVectorIcons cancel
		action: [ :aCoderUIModel :anElement | aCoderUIModel discardChanges ]
		id: GtMethodCoderDiscardChangesActionId
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> mondrianPaintAddOnFor: anAST into: coderAddOns [
	"<gtAstCoderAddOns: 7>"
	(self hasObjectAttribute
		and: [ anAST notNil
				and: [ anAST methodNode
						ifNotNil: [ :node | self isMondrianPaintMethod: node ]
						ifNil: [ false ] ] ])
		ifFalse: [ ^ self ].

	coderAddOns
		addContextAction: 'Mondrian' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anEvent | self runMondrianPaintFrom: anEvent currentTarget ]
]

{ #category : #'api - refactorings' }
GtPharoMethodCoderPromised >> moveMethodToInstanceOrClass [
	| oldClass newClass model modelClass oldModelClass |
	oldClass := self behavior.
	newClass := oldClass isMeta
		ifTrue: [ oldClass soleInstance ]
		ifFalse: [ oldClass class ].
	self isNewMethod
		ifTrue: [ self behavior: newClass.
			^ true ].
	self canMoveMethodToInstanceOrClass
		ifFalse: [ ^ false ].
	model := RBNamespace new.
	modelClass := model classFor: newClass.
	modelClass
		compile: self currentSourceString
		classified: self protocol.
	oldModelClass := model classFor: oldClass.
	(oldModelClass directlyDefinesMethod: self currentSelector)
		ifTrue: [ oldModelClass removeMethod: self currentSelector ].
	self behavior: newClass.
	[ model changes execute ]
		ifCurtailed: [ self behavior: oldClass ].
	^ true
]

{ #category : #'private - actions' }
GtPharoMethodCoderPromised >> newMethodSource [
	self
		deprecated: 'Use #currentSourceString instead.'
		transformWith: '`@receiver newMethodSource' -> '`@receiver currentSourceString'.

	^ self currentSourceString
]

{ #category : #updating }
GtPharoMethodCoderPromised >> newRbAST: aString [
	| ast |
	self isModified
		ifFalse: [ self compiledMethod ifNotNil: [ :m | ^ m ast ] ].
	ast := self parseMethod: aString.
	ast isParseError
		ifTrue: [ ^ ast ].
	ast doSemanticAnalysis.
	^ ast
]

{ #category : #'private - refactorings' }
GtPharoMethodCoderPromised >> nodeDescription: aNode [
	| description |
	description := aNode source asString.
	description size > 40
		ifTrue: [ description := (description first: 40) , '...' ].
	^ ((description copyReplaceAll: String cr with: ' ')
		copyReplaceAll: String lf
		with: ' ') copyReplaceAll: '	' with: ' '
]

{ #category : #'private - notifying' }
GtPharoMethodCoderPromised >> notifyClassAdded [
	self announce: (GtCoderClassAdded new coder: self)
]

{ #category : #'private - notifying' }
GtPharoMethodCoderPromised >> notifyClassRemoved [
	self announce: (GtCoderClassRemoved new coder: self)
]

{ #category : #'private - notifying' }
GtPharoMethodCoderPromised >> notifyClassRenamed [
	self announce: (GtCoderClassRenamed new coder: self)
]

{ #category : #'private - notifying' }
GtPharoMethodCoderPromised >> notifyMethodAdded [
	self announce: (GtCoderMethodAdded new coder: self)
]

{ #category : #'private - notifying' }
GtPharoMethodCoderPromised >> notifyMethodModified [
	self announce: (GtCoderMethodModified new coder: self)
]

{ #category : #'private - notifying' }
GtPharoMethodCoderPromised >> notifyMethodRemoved [
	self announce: (GtCoderMethodRemoved new coder: self)
]

{ #category : #accessing }
GtPharoMethodCoderPromised >> object [
	self deprecated: 'Use GtPharoSourceCoderViewModel>>#selfObject instead'.

	^ UndefinedObject
]

{ #category : #'event handling' }
GtPharoMethodCoderPromised >> onClassAdded: aClassAddedAnnouncement [
	(self methodBehavior affectedByClassAdded: aClassAddedAnnouncement)
		ifFalse: [ ^ self ].

	methodBehavior := self methodBehavior affectByClassAdded: aClassAddedAnnouncement.
	self notifyClassAdded
]

{ #category : #'event handling' }
GtPharoMethodCoderPromised >> onClassRemoved: aClassRemovedAnnouncement [
	(self methodBehavior affectedByClassRemoved: aClassRemovedAnnouncement)
		ifFalse: [ ^ self ].
		
	methodBehavior := self methodBehavior affectByClassRemoved: aClassRemovedAnnouncement.
	self notifyClassRemoved
]

{ #category : #'event handling' }
GtPharoMethodCoderPromised >> onClassRenamed: aClassRenamedAnnouncement [
	(self methodBehavior affectedByClassRenamed: aClassRenamedAnnouncement)
		ifFalse: [ ^ self ].

	methodBehavior := self methodBehavior affectByClassRenamed: aClassRenamedAnnouncement.
	self notifyClassRenamed
]

{ #category : #'event handling' }
GtPharoMethodCoderPromised >> onMethodAdded: aMethodAddedAnnouncement [

	(aMethodAddedAnnouncement methodAdded methodClass = self behavior
		and: [ aMethodAddedAnnouncement methodAdded selector = self selector ])
			ifFalse: [ ^ self ].

	self isModified
		ifFalse: [ self forMethod: aMethodAddedAnnouncement methodAdded ]
		ifTrue: [ self sourceCode: (self sourceCode asCompiledMethodSourceCode: aMethodAddedAnnouncement methodAdded) ].

	self notifyMethodAdded
]

{ #category : #'event handling' }
GtPharoMethodCoderPromised >> onMethodModified: aMethodModified [
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
GtPharoMethodCoderPromised >> onMethodRemoved: aMethodRemovedAnnouncement [

	(aMethodRemovedAnnouncement methodRemoved methodClass = self behavior
		and: [ aMethodRemovedAnnouncement methodRemoved selector = self selector ])
			ifFalse: [ ^ self ].

	self notifyMethodRemoved
]

{ #category : #'api - accessing' }
GtPharoMethodCoderPromised >> package [
	^ super package
		ifNil: [ self compiledMethod
				ifNil: [ self behavior ifNotNil: [ :cls | cls package ] ]
				ifNotNil: [ :method | method package ] ]
]

{ #category : #'api - accessing' }
GtPharoMethodCoderPromised >> packageTag [
	^ super packageTag
		ifNil: [ self compiledMethod
				ifNotNil: [ :method | 
					method isExtension
						ifFalse: [ self package
								ifNotNil: [ :package | 
									| cls |
									cls := self behavior.
									cls category asString = package name asString
										ifFalse: [ package classTagForClass: cls ] ] ] ] ]
]

{ #category : #private }
GtPharoMethodCoderPromised >> performMethodRefactoring: refactoring [
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
GtPharoMethodCoderPromised >> playAllAndInspectInContext: aGtPharoSourceCoderEvaluationContext [
	"Save and execute a method"

	self isModified
		ifTrue: [
			self save
				ifFalse: [ ^ self ] ].

	^ self
		evaluateSelector: self selector
		inContext: aGtPharoSourceCoderEvaluationContext
		thenDo: [ :anEvaluationResult | self notifyObjectSpawnFromEvaluationResult: anEvaluationResult ]
]

{ #category : #'api - actions' }
GtPharoMethodCoderPromised >> playAllInContext: aGtPharoSourceCoderEvaluationContext [
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
GtPharoMethodCoderPromised >> playAndInspectExample [
	self playExample.
	self notifyObjectSpawn: self exampleResult returnValueOrExampleException
]

{ #category : #'api - actions examples' }
GtPharoMethodCoderPromised >> playAndInspectSlide [

	self isModified
		ifTrue: [
			self save
				ifFalse: [ ^ self ] ].

	self notifyObjectSpawn: self compiledMethod gtSlide
]

{ #category : #'api - actions examples' }
GtPharoMethodCoderPromised >> playAndInspectSlideFrom: anEditorElement [

	self isModified
		ifTrue: [
			self save
				ifFalse: [ ^ self ] ].

	self
		notifyObjectSpawn: self compiledMethod gtSlide returnValueOrExampleException
]

{ #category : #'api - actions examples' }
GtPharoMethodCoderPromised >> playExample [
	self isModified
		ifTrue: [
			self save
				ifFalse: [ ^ self ] ].

	self example run
]

{ #category : #'gt-extensions' }
GtPharoMethodCoderPromised >> previewElement [
	"Return a preview element for the Spotter"
	<return: #BlElement>

	^ (self class forClass: self behavior source: self currentSourceString)
		expanded: true;
		asElement
]

{ #category : #printing }
GtPharoMethodCoderPromised >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self behavior asString;
		nextPutAll: '>>#';
		nextPutAll: self selector asString;
		nextPut: $)
]

{ #category : #'api - accessing' }
GtPharoMethodCoderPromised >> protocol [
	<return: #String or: nil>

	^ self
		attributeNamed: #category
		ifAbsent: [
			(self behavior notNil and: [ self selector notNil ])
				ifTrue: [ self behavior whichCategoryIncludesSelector: self selector ] ]
]

{ #category : #'api - accessing' }
GtPharoMethodCoderPromised >> protocol: aSymbol [
	^ self attributeNamed: #category put: aSymbol
]

{ #category : #'api - actions' }
GtPharoMethodCoderPromised >> remove [
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

{ #category : #'private - refactorings' }
GtPharoMethodCoderPromised >> removeHighlightBlock [
	^ [ :textualCoderViewModel | 
	  textualCoderViewModel removeAttribute: self class nodeHighlight ]
]

{ #category : #'api - refactorings' }
GtPharoMethodCoderPromised >> renameProtocol: aString [
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
GtPharoMethodCoderPromised >> reset [
	super reset.
	methodBehavior := GtPharoCoderBehavior unspecified.
	selector := nil.
	self protocol: nil
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> runGtViewFrom: anElement [
	| view |
	
	self isModified
		ifTrue: [
			self save
				ifFalse: [ ^ self ] ].
	
	view := self object perform: self selector with: GtPhlowEmptyView new.
	anElement phlow spawnObject: view
]

{ #category : #'as yet unclassified' }
GtPharoMethodCoderPromised >> runMondrianPaintFrom: anElement [
	| mondrian |
	
	self isModified
		ifTrue: [
			self save
				ifFalse: [ ^ self ] ].
	
	mondrian := GtMondrian new.
	self object perform: self selector with: mondrian.
	anElement phlow spawnObject: mondrian
]

{ #category : #'private - refactorings' }
GtPharoMethodCoderPromised >> safeTemporaryName [
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
GtPharoMethodCoderPromised >> save [
	"Try to save the current method validating syntax and return `true` if save was succesful, false otherwise"
	<return: #Boolean>

	^ self saveInContext: self evaluationContext
]

{ #category : #'api - actions' }
GtPharoMethodCoderPromised >> saveInContext: aGtPharoSourceCoderEvaluationContext [
	"Try to save the current method validating syntax and return `true` if save was succesful, false otherwise"
	<return: #Boolean>

	self validateSyntax
		ifFalse: [ ^ false ].

	(self compileInContext: aGtPharoSourceCoderEvaluationContext)
		ifFalse: [ ^ false ].

	^ true
]

{ #category : #accessing }
GtPharoMethodCoderPromised >> selector [
	"Assign an original selector which changes when the compiled method is assigned.
	The selector of the new method is undefined (nil).
	See #currentSelector if you need to take the source code into account"
	<return: #Symbol or: nil>

	^ selector
]

{ #category : #accessing }
GtPharoMethodCoderPromised >> selector: aSymbol [
	selector := aSymbol
]

{ #category : #private }
GtPharoMethodCoderPromised >> skipBlankLinesIn: source at: startIndex [
	| char index |
	index := startIndex.
	[ index <= source size and: [ (char := source at: index) = Character cr or: [ char = Character lf ] ] ]
		whileTrue: [ index := index + 1 ].
	^ index
]

{ #category : #'api - addons' }
GtPharoMethodCoderPromised >> slideAstFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 10>
	(self compiledMethod notNil
		and: [ anAST notNil
				and: [ 
					anAST methodNode
						ifNotNil: [ :node | 
							node pragmas
								anySatisfy: [ :each | each isErrorNode not and: [ each selector = #gtSlide ] ] ]
						ifNil: [ false ] ] ])
		ifFalse: [ ^ self ].
	(anAST methodNode numArgs = 1) ifFalse: [ ^ self ].
	coderAddOns
		addContextAction: 'Play and Inspect' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anEvent | self playAndInspectSlide ].
]

{ #category : #'api - accessing' }
GtPharoMethodCoderPromised >> sourceCode: aGtCoderSourceCode withStrategy: anUpdateStragegy [
	self clearExample.
	super sourceCode: aGtCoderSourceCode withStrategy: anUpdateStragegy
]

{ #category : #'private - subscriptions' }
GtPharoMethodCoderPromised >> subscribeToSystem [
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
GtPharoMethodCoderPromised >> traitSource [
	^ self compiledMethod 
		ifNotNil: [ :aMethod | aMethod traitSource ] 
		ifNil: [ nil ]
]

{ #category : #'api - addons' }
GtPharoMethodCoderPromised >> unaryMessageAddOnFor: anAST into: coderAddOns viewModel: aGtPharoMethodCoderViewModel [
	<gtAstCoderAddOns: 20>
	| isUnaryInstanceSideMethod isUnaryClassSideMethod |
	
	self compiledMethod ifNil: [ ^ self ].
	
	isUnaryInstanceSideMethod := aGtPharoMethodCoderViewModel selfObject notNil and: [ 
		anAST methodNode selector isUnary ].
	isUnaryClassSideMethod := (anAST notNil
		and: [ anAST methodNode
			ifNotNil: [ :node | node variables isEmpty and: [ self compiledMethod methodClass isClassSide ] ]
			ifNil: [ false ] ] ).
	(isUnaryInstanceSideMethod or: [ isUnaryClassSideMethod ])		
		ifFalse: [ ^ self ].
	coderAddOns
		addContextAction: 'Play' translated
		icon: BrGlamorousVectorIcons play
		action: [ :aCoderUIModel :anElement | 
			GtCoderCodeExecutor playAll
				coderUIModel: aCoderUIModel;
				element: anElement;
				execute ].
	coderAddOns
		addContextAction: 'Play and Inspect' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anElement | 
			GtCoderCodeExecutor playAllAndInspect
				coderUIModel: aCoderUIModel;
				element: anElement;
				execute ].
	coderAddOns
		addContextAction: 'Debug' translated
		icon: BrGlamorousVectorIcons debug
		action: [ :aCoderUIModel :anElement | aCoderUIModel debug ]
]

{ #category : #'private - subscriptions' }
GtPharoMethodCoderPromised >> unsubscribeFromExample [
	self
		attributeNamed: #example
		ifPresent: [ :anOldExampleWithResult | anOldExampleWithResult announcer unsubscribe: self ]
		ifAbsent: [ "do nothing" ].
]
