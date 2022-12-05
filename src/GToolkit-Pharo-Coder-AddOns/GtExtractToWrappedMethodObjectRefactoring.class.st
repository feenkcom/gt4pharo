Class {
	#name : #GtExtractToWrappedMethodObjectRefactoring,
	#superclass : #RBMethodRefactoring,
	#instVars : [
		'selector',
		'interval',
		'superclass',
		'category',
		'className',
		'variablesToMove',
		'newVariableNames',
		'methodObjectSelector',
		'tempName',
		'constructorSelector',
		'receiverClasses',
		'uniqueComponentSelector'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #transforming }
GtExtractToWrappedMethodObjectRefactoring >> addMethodObjectParameterToUnaryMessage [
	| refactoring methodName |
	uniqueComponentSelector ifNil: [ ^ self ].
	methodName := RBMethodName
			selector: (self uniqueMethodNameFor: 1)
			arguments: {self methodObjectArgumentName}.
	methodName := (self options at: #methodName) cull: methodName cull: self.
	refactoring := RBAddParameterRefactoring
			model: model
			addParameterToMethod: uniqueComponentSelector
			in: receiverClasses first
			newSelector: methodName selector
			permutation: {-1}
			newArgs: {RBArgumentName name: methodName arguments first value: 'self'}.
	self performCompositeRefactoring: refactoring
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoring >> category [
	^ category
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoring >> category: aSymbol [
	category := aSymbol
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoring >> className [
	^ className
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoring >> className: aSymbol [
	className := aSymbol
]

{ #category : #transforming }
GtExtractToWrappedMethodObjectRefactoring >> createMethodObjectConstructor [
	| sender |
	sender := self findSenderNode.
	sender parent isCascade ifFalse: [ ^ self ].
	self eliminateCascade.
	self extractConstructor.
	self introduceCascadeInConstructor
]

{ #category : #transforming }
GtExtractToWrappedMethodObjectRefactoring >> eliminateCascade [
	| cascadeRefactoring |
	cascadeRefactoring := GtConvertCascadesToStatementsRefactoring
			model: self model
			convert: self findSenderNode sourceInterval
			inMethod: selector
			forClass: self methodClass.
	cascadeRefactoring
		setOption: #receiverName
		toUse: [ :ref | 
			tempName := '_'
					, (SharedRandom globalGenerator nextInteger: SmallInteger maxVal) printString ].
	self performCompositeRefactoring: cascadeRefactoring
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoring >> extract: anInterval from: aSelector in: aClass [
	interval := anInterval.
	selector := aSelector.
	class := aClass
]

{ #category : #transforming }
GtExtractToWrappedMethodObjectRefactoring >> extractConstructor [
	| node parents sequenceIndex sequence first last refactoring |
	node := self findSenderNode.
	parents := node withAllParents reversed.
	sequenceIndex := (1 to: parents size)
			detect: [ :i | (parents at: i) isSequence ].
	sequence := parents at: sequenceIndex.
	first := sequence statements
			detect: [ :each | each isAssignment and: [ each variable name = tempName ] ].
	last := sequence statements
			at: (sequence statements identityIndexOf: (parents at: sequenceIndex - 1)) - 1.
	refactoring := GtExtractMethodToComponentRefactoring
			model: self model
			extract: (first start to: last stop)
			from: self selector
			in: self methodClass.
	refactoring
		setOption: #methodName
			toUse: [ :methodName :ref | 
				| result |
				result := (self options at: #constructorMethodName)
						cull: methodName
						cull: ref.
				constructorSelector := result selector.
				result ];
		setOption: #selectVariableToMoveTo toUse: [ :ref :cls :sel | self className ];
		setOption: #variableTypes
			toUse: [ :ref :types :selected | {(ref model classNamed: self className) classSide} ].
	self performCompositeRefactoring: refactoring
]

{ #category : #transforming }
GtExtractToWrappedMethodObjectRefactoring >> extractToMethodObject [
	| refactoring |
	refactoring := GtExtractMethodObjectRefactoring new
			model: self model;
			extract: interval
				from: selector
				in: class;
			className: className;
			superclass: superclass;
			category: category;
			variables: variablesToMove withAccessorNames: newVariableNames;
			setOption: #methodName
				toUse: [ :methodName | 
					methodObjectSelector := self uniqueMethodNameFor: methodName arguments size.
					methodName
						selector: methodObjectSelector;
						yourself ];
			setOption: #useExistingMethod toUse: [ :ref1 :sel1 | false ].
	self performCompositeRefactoring: refactoring
]

{ #category : #transforming }
GtExtractToWrappedMethodObjectRefactoring >> findSenderNode [
	(self methodClass parseTreeFor: self selector)
		nodesDo: [ :node | 
			(node isMessage and: [ node selector = methodObjectSelector ])
				ifTrue: [ ^ node ] ].
	self refactoringError: 'Could not find extracted send'
]

{ #category : #transforming }
GtExtractToWrappedMethodObjectRefactoring >> inlineMovedMethodForwarder [
	| refactoring |
	refactoring := RBInlineMethodFromComponentRefactoring
			model: model
			inline: self findSenderNode sourceInterval
			inMethod: selector
			forClass: self methodClass.
	refactoring setOption: #inlineExpression toUse: [ :ref :string | true ].
	self performCompositeRefactoring: refactoring.
	self
		performCompositeRefactoring: (RBRemoveMethodRefactoring
				model: self model
				removeMethods: {methodObjectSelector}
				from: (self model classNamed: self className))
]

{ #category : #transforming }
GtExtractToWrappedMethodObjectRefactoring >> inlineTempIn: aRBMethod [
	| refactoring node |
	aRBMethod ast
		nodesDo: [ :each | 
			(each isAssignment and: [ each variable name = tempName ])
				ifTrue: [ node := each ] ].
	refactoring := RBInlineTemporaryRefactoring
			model: self model
			inline: node sourceInterval
			from: aRBMethod selector
			in: aRBMethod methodClass.
	self performCompositeRefactoring: refactoring
]

{ #category : #transforming }
GtExtractToWrappedMethodObjectRefactoring >> inlineTemps [
	tempName ifNil: [ ^ self ].
	self inlineTempIn: (self methodClass methodFor: self selector).
	self
		inlineTempIn: ((self model classNamed: className) classSide methodFor: constructorSelector)
]

{ #category : #transforming }
GtExtractToWrappedMethodObjectRefactoring >> introduceCascadeInConstructor [
	| refactoring node newClass |
	newClass := (self model classNamed: className) classSide.
	node := newClass parseTreeFor: constructorSelector.
	refactoring := GtConvertStatementsToCascadesRefactoring
			model: self model
			convert: (node body statements first start
					to: (node body statements at: node body statements size - 1) stop)
			inMethod: constructorSelector
			forClass: newClass.
	self performCompositeRefactoring: refactoring
]

{ #category : #transforming }
GtExtractToWrappedMethodObjectRefactoring >> methodObjectArgumentName [
	^ (className first isVowel ifTrue: [ 'an' ] ifFalse: [ 'a' ]) , self className
]

{ #category : #transforming }
GtExtractToWrappedMethodObjectRefactoring >> moveExtractedMethodToComponent [
	| variable refactoring |
	variable := self
			selectVariableToMoveMethodTo: methodObjectSelector
			class: class.
	variable ifNil: [ self refactoringFailure: 'Did not extract method' ].
	refactoring := GtMoveMethodRefactoring
			model: self model
			selector: methodObjectSelector
			class: (self model classNamed: self className)
			variable: variable.
	refactoring
		setOption: #selfArgumentName toUse: [ :ref | self methodObjectArgumentName ];
		setOption: #methodName
			toUse: [ :methodName :ref | 
				methodName arguments isEmpty
					ifTrue: [ uniqueComponentSelector := ref uniqueMethodNameFor: 0.
						methodName
							selector: uniqueComponentSelector;
							yourself ]
					ifFalse: [ (self options at: #methodName) cull: methodName cull: ref ] ];
		setOption: #variableTypes
			toUse: [ :ref :types :selected | 
				receiverClasses := (self options at: #variableTypes)
						cull: ref
						cull: types
						cull: selected ].
	self performCompositeRefactoring: refactoring
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoring >> preconditions [
	^ RBCondition definesSelector: selector in: class
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoring >> selector [
	^ selector
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoring >> superclass [
	^ superclass
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoring >> superclass: aSymbol [
	superclass := aSymbol
]

{ #category : #transforming }
GtExtractToWrappedMethodObjectRefactoring >> transform [
	self extractToMethodObject.
	self moveExtractedMethodToComponent.
	self addMethodObjectParameterToUnaryMessage.
	self createMethodObjectConstructor.
	self inlineMovedMethodForwarder.
	self inlineTemps.
	self gtCleanupChanges
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoring >> variables: originalVariableNames withAccessorNames: namesCollection [
	variablesToMove := originalVariableNames.
	newVariableNames := namesCollection
]
