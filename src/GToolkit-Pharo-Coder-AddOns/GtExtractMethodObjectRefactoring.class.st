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
		'newVariableNames'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #accessing }
GtExtractMethodObjectRefactoring >> abstractVariablesInExtractedMethod [
	| refactoring ast |
	ast := class parseTreeFor: extractedMethodSelector.
	refactoring := RBAbstractVariablesRefactoring
			model: self model
			abstractVariablesIn: ast
			from: class
			toAll: {self model classNamed: className}
			ignoring: ''.
	refactoring hasVariablesToAbstract
		ifTrue: [ self performCompositeRefactoring: refactoring.
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
GtExtractMethodObjectRefactoring >> createClassInstance [
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
GtExtractMethodObjectRefactoring >> newClassInstanceTemp [
	^ '_' , className
]

{ #category : #preconditions }
GtExtractMethodObjectRefactoring >> preconditions [
	^ self emptyCondition
]

{ #category : #accessing }
GtExtractMethodObjectRefactoring >> selector [
	^ selector
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
	self extractMethod.
	self addClass.
	self abstractVariablesInExtractedMethod.
	self createClassInstance.
	self moveDataToClass.
	self extractToNewClass.
	self inlineAssignment.
	self convertCascadedConstructor.
	self inlineMessage.
	self gtCleanupChanges
]

{ #category : #accessing }
GtExtractMethodObjectRefactoring >> variables: originalVariableNames withAccessorNames: namesCollection [
	variablesToMove := originalVariableNames.
	newVariableNames := namesCollection
]
