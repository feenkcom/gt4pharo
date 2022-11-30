Class {
	#name : #GtExtractToParagraphRefactoring,
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
		'constructorSelector'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #accessing }
GtExtractToParagraphRefactoring >> category [
	^ category
]

{ #category : #accessing }
GtExtractToParagraphRefactoring >> category: aSymbol [
	category := aSymbol
]

{ #category : #accessing }
GtExtractToParagraphRefactoring >> className [
	^ className
]

{ #category : #accessing }
GtExtractToParagraphRefactoring >> className: aSymbol [
	className := aSymbol
]

{ #category : #transforming }
GtExtractToParagraphRefactoring >> createMethodObjectConstructor [
	| sender |
	sender := self findSenderNode.
	sender parent isCascade ifFalse: [ ^ self ].
	self eliminateCascade.
	self extractConstructor.
	self introduceCascadeInConstructor
]

{ #category : #transforming }
GtExtractToParagraphRefactoring >> eliminateCascade [
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
GtExtractToParagraphRefactoring >> extract: anInterval from: aSelector in: aClass [
	interval := anInterval.
	selector := aSelector.
	class := aClass
]

{ #category : #transforming }
GtExtractToParagraphRefactoring >> extractConstructor [
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
GtExtractToParagraphRefactoring >> extractToMethodObject [
	| refactoring |
	refactoring := GtMethodObjectRefactoring new
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
GtExtractToParagraphRefactoring >> findSenderNode [
	(self methodClass parseTreeFor: self selector)
		nodesDo: [ :node | 
			(node isMessage and: [ node selector = methodObjectSelector ])
				ifTrue: [ ^ node ] ].
	self refactoringError: 'Could not find extracted send'
]

{ #category : #transforming }
GtExtractToParagraphRefactoring >> inlineMovedMethodForwarder [
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
GtExtractToParagraphRefactoring >> inlineTempIn: aRBMethod [
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
GtExtractToParagraphRefactoring >> inlineTemps [
	tempName ifNil: [ ^ self ].
	self inlineTempIn: (self methodClass methodFor: self selector).
	self
		inlineTempIn: ((self model classNamed: className) classSide methodFor: constructorSelector)
]

{ #category : #transforming }
GtExtractToParagraphRefactoring >> introduceCascadeInConstructor [
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
GtExtractToParagraphRefactoring >> moveExtractedMethodToComponent [
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
		setOption: #selfArgumentName
		toUse: [ :ref | (className first isVowel ifTrue: [ 'an' ] ifFalse: [ 'a' ]) , self className ].
	self performCompositeRefactoring: refactoring
]

{ #category : #accessing }
GtExtractToParagraphRefactoring >> preconditions [
	^ RBCondition definesSelector: selector in: class
]

{ #category : #accessing }
GtExtractToParagraphRefactoring >> selector [
	^ selector
]

{ #category : #accessing }
GtExtractToParagraphRefactoring >> superclass [
	^ superclass
]

{ #category : #accessing }
GtExtractToParagraphRefactoring >> superclass: aSymbol [
	superclass := aSymbol
]

{ #category : #transforming }
GtExtractToParagraphRefactoring >> transform [
	self extractToMethodObject.
	self moveExtractedMethodToComponent.
	self createMethodObjectConstructor.
	self inlineMovedMethodForwarder.
	self inlineTemps.
	self gtCleanupChanges
]

{ #category : #accessing }
GtExtractToParagraphRefactoring >> variables: originalVariableNames withAccessorNames: namesCollection [
	variablesToMove := originalVariableNames.
	newVariableNames := namesCollection
]
