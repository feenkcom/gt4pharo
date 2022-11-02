Class {
	#name : #GtMethodObjectRefactoring,
	#superclass : #RBMethodRefactoring,
	#instVars : [
		'selector',
		'interval',
		'extractedMethodSelector',
		'superclass',
		'category',
		'className',
		'variablesToMove',
		'newVariableNames'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #transforming }
GtMethodObjectRefactoring >> addClass [
	self
		performCompositeRefactoring: (RBAddClassRefactoring
				model: self model
				addClass: className
				superclass: superclass
				subclasses: #()
				category: category)
]

{ #category : #accessing }
GtMethodObjectRefactoring >> category [
	^ category
]

{ #category : #accessing }
GtMethodObjectRefactoring >> category: aSymbol [
	category := aSymbol
]

{ #category : #accessing }
GtMethodObjectRefactoring >> className [
	^ className
]

{ #category : #accessing }
GtMethodObjectRefactoring >> className: aSymbol [
	className := aSymbol
]

{ #category : #transforming }
GtMethodObjectRefactoring >> convertCascadedConstructor [
	| rewriter ast |
	ast := self modelClass parseTreeFor: extractedMethodSelector.
	rewriter := RBParseTreeRewriter new.
	rewriter
		replace: '((' , className , ' `@msg: `@args) `@;messages; yourself) `@msg2: `@args2'
		with: '(' , className , ' `@msg: `@args) `@;messages; `@msg2: `@args2'.
	(rewriter executeTree: ast)
		ifTrue: [ self modelClass compileTree: rewriter tree ]
]

{ #category : #transforming }
GtMethodObjectRefactoring >> createClassInstance [
	| tree |
	tree := self extractedAst.
	tree body addTemporaryNamed: '_' , className.
	tree body
		addNodeFirst: (RBAssignmentNode
				variable: (RBVariableNode named: self newClassInstanceTemp)
				value: (RBMessageNode receiver: (RBVariableNode named: className) selector: #new)).
	self modelClass compileTree: tree
]

{ #category : #initialization }
GtMethodObjectRefactoring >> extract: anInterval from: aSelector in: aClass [
	interval := anInterval.
	selector := aSelector.
	class := aClass
]

{ #category : #transforming }
GtMethodObjectRefactoring >> extractMethod [
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
				yourself ].
	self performCompositeRefactoring: refactoring
]

{ #category : #transforming }
GtMethodObjectRefactoring >> extractToNewClass [
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
			toUse: [ :ref :types :selected | {self methodObjectClass} ].
	self performCompositeRefactoring: refactoring
]

{ #category : #transforming }
GtMethodObjectRefactoring >> extractedAst [
	| source modelClass |
	modelClass := self modelClass.
	source := modelClass sourceCodeFor: extractedMethodSelector.
	^ RBParser parseMethod: source
]

{ #category : #transforming }
GtMethodObjectRefactoring >> inlineAssignment [
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
GtMethodObjectRefactoring >> inlineMessage [
	self
		performCompositeRefactoring: (RBInlineAllSendersRefactoring
				model: self model
				sendersOf: extractedMethodSelector
				in: class)
]

{ #category : #transforming }
GtMethodObjectRefactoring >> methodObjectClass [
	^ self model classNamed: className
]

{ #category : #transforming }
GtMethodObjectRefactoring >> modelClass [
	^ self model classObjectFor: class
]

{ #category : #transforming }
GtMethodObjectRefactoring >> moveDataToClass [
	variablesToMove
		with: newVariableNames
		do: [ :oldName :newName | 
			self
				performCompositeRefactoring: (GtMoveTempToObjectRefactoring
						model: self model
						class: self modelClass
						selector: extractedMethodSelector
						temp: oldName
						intoTemp: self newClassInstanceTemp
						instVar: newName) ]
]

{ #category : #transforming }
GtMethodObjectRefactoring >> newClassInstanceTemp [
	^ '_' , className
]

{ #category : #preconditions }
GtMethodObjectRefactoring >> preconditions [
	^ self emptyCondition
]

{ #category : #accessing }
GtMethodObjectRefactoring >> superclass [
	^ superclass
]

{ #category : #accessing }
GtMethodObjectRefactoring >> superclass: aSymbol [
	superclass := aSymbol
]

{ #category : #transforming }
GtMethodObjectRefactoring >> transform [
	self extractMethod.
	self addClass.
	self createClassInstance.
	self moveDataToClass.
	self extractToNewClass.
	self inlineAssignment.
	self convertCascadedConstructor.
	self inlineMessage.
	self gtCleanupChanges
]

{ #category : #accessing }
GtMethodObjectRefactoring >> variables: originalVariableNames withAccessorNames: namesCollection [
	variablesToMove := originalVariableNames.
	newVariableNames := namesCollection
]
