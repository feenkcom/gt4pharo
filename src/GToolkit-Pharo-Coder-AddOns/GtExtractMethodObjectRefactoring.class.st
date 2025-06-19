Class {
	#name : #GtExtractMethodObjectRefactoring,
	#superclass : #RBMethodRefactoring,
	#instVars : [
		'selector',
		'interval',
		'extractedMethodSelector',
		'superclass',
		'category',
		'className',
		'variablesToMove',
		'ivarsToMove'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #accessing }
GtExtractMethodObjectRefactoring >> abstractVariablesInExtractedMethod [
	| refactoring ast |
	ivarsToMove := Set new.
	ast := class parseTreeForSelector: extractedMethodSelector.
	refactoring := RBAbstractVariablesRefactoring
			model: self model
			abstractVariablesIn: ast
			from: class
			toAll: {self model classNamed: className}
			ignoring: ''.
	refactoring hasVariablesToAbstract
		ifTrue: [ refactoring copyOptionsFrom: self options.
			self canSplitLifetimes
				ifTrue: [ refactoring abstractClassVariables.
					ivarsToMove := refactoring gtInstanceVariableReaders
							reject: [ :each | refactoring gtInstanceVariableWriters includes: each ].
					refactoring gtInstanceVariableWriters
						do: [ :each | refactoring abstractInstanceVariable: each ] ]
				ifFalse: [ self performCompositeRefactoring: refactoring ].
			class compileTree: ast ]
]

{ #category : #transforming }
GtExtractMethodObjectRefactoring >> addClass [
	self
		performCompositeRefactoring: (RBAddClassRefactoring
				model: self model
				addClass: className
				superclass: superclass
				subclasses: #()
				category: category)
]

{ #category : #transforming }
GtExtractMethodObjectRefactoring >> addSelfReturn [
	| ast hasReturn |
	ast := class parseTreeForSelector: extractedMethodSelector.
	hasReturn := false.
	ast nodesDo: [ :each | each isReturn ifTrue: [ hasReturn := true ] ].
	hasReturn ifFalse: [ ^ self ].
	((self gtUsesSendOf: extractedMethodSelector)
		or: [ self hasSelfReferenceIn: ast ])
		ifTrue: [ ast addSelfReturn.
			class compileTree: ast ]
]

{ #category : #transforming }
GtExtractMethodObjectRefactoring >> basicTransform [
	self extractMethod.
	self addClass.
	self abstractVariablesInExtractedMethod.
	self createClassInstance.
	self addSelfReturn.
	self moveDataToClass.
	self extractToNewClass.
	self inlineAssignment.
	self convertCascadedConstructor.
	self inlineMessage.
	self gtCleanupChanges
]

{ #category : #transforming }
GtExtractMethodObjectRefactoring >> cascadeExtractedMessage [
	| rewriter ast |
	self shouldEliminateYourselfFromConstructor ifFalse: [ ^ self ].
	ast := self modelClass parseTreeForSelector: extractedMethodSelector.
	rewriter := RBParseTreeRewriter new.
	rewriter
		replace: '((' , className , ' `@msg: `@args) `@;messages; yourself) `@msg2: `@args2'
		with: '(' , className , ' `@msg: `@args) `@;messages; `@msg2: `@args2'.
	(rewriter executeTree: ast)
		ifTrue: [ self modelClass compileTree: rewriter tree ]
]

{ #category : #accessing }
GtExtractMethodObjectRefactoring >> category [
	^ category
]

{ #category : #accessing }
GtExtractMethodObjectRefactoring >> category: aSymbol [
	category := aSymbol
]

{ #category : #accessing }
GtExtractMethodObjectRefactoring >> className [
	^ className
]

{ #category : #accessing }
GtExtractMethodObjectRefactoring >> className: aSymbol [
	className := aSymbol
]

{ #category : #transforming }
GtExtractMethodObjectRefactoring >> convertCascadedConstructor [
	| constructorName |
	constructorName := RBMethodName new.
	constructorName selector: (self uniqueMethodNameFor: self variablesToMove size).
	constructorName arguments: self variablesToMove , ivarsToMove asArray.
	((self options
		at: #constructorMethodName
		ifAbsent: [ [ :methodName :ref | nil ] ]) cull: constructorName cull: self)
		ifNil: [ self cascadeExtractedMessage ]
		ifNotNil: [ :methodName | self createConstructor: methodName ]
]

{ #category : #transforming }
GtExtractMethodObjectRefactoring >> createClassInstance [
	| tree |
	tree := self extractedAst.
	tree body addTemporaryNamed: self newClassInstanceTemp.
	tree body
		addNodeFirst: (RBAssignmentNode
				variable: (RBVariableNode named: self newClassInstanceTemp)
				value: (RBMessageNode receiver: (RBVariableNode named: className) selector: #new)).
	self modelClass compileTree: tree
]

{ #category : #transforming }
GtExtractMethodObjectRefactoring >> createConstructor: methodName [
	| node ast refactoring |
	ast := self modelClass parseTreeForSelector: extractedMethodSelector.
	ast
		nodesDo: [ :each | 
			(each isMessage
				and: [ each selector = #yourself
						and: [ each receiver isMessage
								and: [ each receiver receiver isVariable
										and: [ each receiver receiver name = className ] ] ] ])
				ifTrue: [ node := each ] ].
	node ifNil: [ ^ self ].
	refactoring := GtExtractMethodToComponentRefactoring
			model: model
			extract: (node start to: node stop)
			from: extractedMethodSelector
			in: self modelClass.
	refactoring
		setOption: #methodName
			toUse: [ :mn :ref | 
				mn selector: methodName selector.
				mn
					arguments: (methodName arguments
							collect: [ :each | each = 'self' ifTrue: [ self requestSelfArgumentName ] ifFalse: [ each ] ]).
				mn ];
		setOption: #selectVariableToMoveTo toUse: [ :ref :cls :sel | className ];
		setOption: #variableTypes
			toUse: [ :ref :types :selected | {self methodObjectClass classSide} ];
		setOption: #useExistingMethod toUse: [ :ref :sel | false ].
	self performCompositeRefactoring: refactoring.
	self model changes
		gtSelector: methodName selector
		in: (self model classNamed: className) classSide
		classified: #'instance creation'
]

{ #category : #initialization }
GtExtractMethodObjectRefactoring >> extract: anInterval from: aSelector in: aClass [
	interval := anInterval.
	selector := aSelector.
	class := aClass
]

{ #category : #transforming }
GtExtractMethodObjectRefactoring >> extractMethod [
	| refactoring |
	refactoring := RBExtractMethodRefactoring
			model: self model
			extract: interval
			from: selector
			in: class.
	refactoring
		setOption: #methodName
			toUse: [ :methodName :ref | 
				extractedMethodSelector := self uniqueMethodNameFor: methodName arguments size.
				methodName
					selector: extractedMethodSelector;
					yourself ];
		setOption: #useExistingMethod toUse: [ :ref :sel | false ].
	self performCompositeRefactoring: refactoring
]

{ #category : #transforming }
GtExtractMethodObjectRefactoring >> extractToNewClass [
	| refactoring ast |
	ast := self extractedAst body.
	refactoring := GtExtractMethodToComponentRefactoring
			model: model
			extract: (ast statements second start to: ast statements last stop)
			from: extractedMethodSelector
			in: self modelClass.
	refactoring
		setOption: #selectVariableToMoveTo
			toUse: [ :ref :cls :sel | '_' , className ];
		setOption: #variableTypes
			toUse: [ :ref :types :selected | {self methodObjectClass} ];
		setOption: #useExistingMethod toUse: [ :ref :sel | false ].
	self performCompositeRefactoring: refactoring
]

{ #category : #transforming }
GtExtractMethodObjectRefactoring >> extractedAst [
	| source modelClass |
	modelClass := self modelClass.
	source := modelClass sourceCodeFor: extractedMethodSelector.
	^ RBParser parseMethod: source
]

{ #category : #accessing }
GtExtractMethodObjectRefactoring >> extractedMethodSelector [
	^ extractedMethodSelector
]

{ #category : #accessing }
GtExtractMethodObjectRefactoring >> gtDescription [
	^ 'Extract method object ' , className
]

{ #category : #testing }
GtExtractMethodObjectRefactoring >> hasSelfReferenceIn: ast [
	| checkedReturn |
	checkedReturn := false.
	ast
		nodesDo: [ :each | 
			(each isVariable and: [ each isSelfVariable ])
				ifTrue: [ each parent isReturn
						ifTrue: [ checkedReturn
								ifFalse: [ checkedReturn := true.
									(self gtUsesSendOf: extractedMethodSelector) ifTrue: [ ^ true ] ] ]
						ifFalse: [ ^ true ] ] ].
	^ false
]

{ #category : #transforming }
GtExtractMethodObjectRefactoring >> inlineAssignment [
	| tree |
	tree := self extractedAst.
	self
		performCompositeRefactoring: (RBInlineTemporaryRefactoring
				model: self model
				inline: tree body statements first sourceInterval
				from: extractedMethodSelector
				in: class)
]

{ #category : #transforming }
GtExtractMethodObjectRefactoring >> inlineMessage [
	self
		performCompositeRefactoring: (GtInlineAllSendersRefactoring
				model: self model
				sendersOf: extractedMethodSelector
				in: class)
]

{ #category : #transforming }
GtExtractMethodObjectRefactoring >> methodObjectClass [
	^ self model classNamed: className
]

{ #category : #transforming }
GtExtractMethodObjectRefactoring >> modelClass [
	^ self model classObjectFor: class
]

{ #category : #transforming }
GtExtractMethodObjectRefactoring >> moveDataToClass [
	self variablesToMove do: [ :each | self moveVariableToClass: each ].
	ivarsToMove do: [ :each | self moveVariableToClass: each ]
]

{ #category : #transforming }
GtExtractMethodObjectRefactoring >> moveVariableToClass: oldName [
	^ self
		performCompositeRefactoring: (GtMoveTempToObjectRefactoring
				model: self model
				class: self modelClass
				selector: extractedMethodSelector
				temp: oldName
				intoTemp: self newClassInstanceTemp
				instVar: ((self options at: #newVariableName) cull: oldName cull: self))
]

{ #category : #transforming }
GtExtractMethodObjectRefactoring >> newClassInstanceTemp [
	^ '_' , className
]

{ #category : #preconditions }
GtExtractMethodObjectRefactoring >> preconditions [
	^ self emptyCondition
]

{ #category : #transforming }
GtExtractMethodObjectRefactoring >> privateTranform [
	self basicTransform
]

{ #category : #accessing }
GtExtractMethodObjectRefactoring >> selector [
	^ selector
]

{ #category : #testing }
GtExtractMethodObjectRefactoring >> shouldEliminateYourselfFromConstructor [
	^ true
]

{ #category : #accessing }
GtExtractMethodObjectRefactoring >> superclass [
	^ superclass
]

{ #category : #accessing }
GtExtractMethodObjectRefactoring >> superclass: aSymbol [
	superclass := aSymbol
]

{ #category : #transforming }
GtExtractMethodObjectRefactoring >> transform [
	self basicTransform
]

{ #category : #accessing }
GtExtractMethodObjectRefactoring >> variablesToMove [
	^ variablesToMove
		ifNil: [ | vars ast |
			ast := class parseTreeForSelector: extractedMethodSelector.
			vars := (ast arguments collect: #name) asOrderedCollection.
			(self hasSelfReferenceIn: ast) ifTrue: [ vars add: 'self' ].
			variablesToMove := (self options at: #variablesToMove) cull: vars cull: self ]
]
