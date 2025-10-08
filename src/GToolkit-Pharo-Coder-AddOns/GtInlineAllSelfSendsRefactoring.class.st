Class {
	#name : #GtInlineAllSelfSendsRefactoring,
	#superclass : #RBMethodRefactoring,
	#instVars : [
		'selector',
		'recursiveMethods',
		'ignoreSelectors'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #examples }
GtInlineAllSelfSendsRefactoring class >> inlineWithIgnoredExample [
	| model refactoring cls |
	model := self sampleModelExample.
	cls := model classFor: self.
	cls
		compile: 'unknown
		^42'
		classified: #testing.
	refactoring := self
			model: model
			selector: #foo:
			class: cls.
	refactoring ignoreSelectors: #(bar).
	refactoring primitiveExecute.
	self
		assert: (cls methodFor: #foo:) ast
		equals: (RBParser
				parseMethod: 'foo: anInteger
									^ self bar + (self baz: anInteger) + 42').
	^ model
]

{ #category : #examples }
GtInlineAllSelfSendsRefactoring class >> inlineWithRecursiveExample [
	| model cls refactoring |
	model := self sampleModelExample.
	cls := model classFor: self.
	refactoring := self
			model: model
			selector: #foo:
			class: cls.
	refactoring primitiveExecute.
	self
		assert: (cls methodFor: #foo:) ast
		equals: (RBParser
				parseMethod: 'foo: anInteger
									^ 42 + (self baz: anInteger) + self unknown').
	^ model
]

{ #category : #'instance creation' }
GtInlineAllSelfSendsRefactoring class >> model: aRBNamespace selector: aSymbol class: aClass [
	^ self new
		model: aRBNamespace;
		selector: aSymbol;
		class: aClass;
		yourself
]

{ #category : #examples }
GtInlineAllSelfSendsRefactoring class >> sampleModelExample [
	| model cls |
	model := GtRBNamespace new.
	cls := model classFor: self.
	cls
		compile: 'foo: anInteger
		^self bar + (self baz: anInteger) + self unknown'
		classified: #testing.
	cls
		compile: 'bar
		^42'
		classified: #testing.
	cls
		compile: 'baz: anInteger
		^anInteger < 2 ifTrue: [1] ifFalse: [(self baz1: anInteger) + 1]'
		classified: #testing.
	cls
		compile: 'baz1: anInteger
		^self baz: anInteger >> 1'
		classified: #testing.
	^ model
]

{ #category : #'instance creation' }
GtInlineAllSelfSendsRefactoring class >> selector: aSymbol class: aClass [
	^ self new
		selector: aSymbol;
		class: aClass;
		yourself
]

{ #category : #transforming }
GtInlineAllSelfSendsRefactoring >> ast [
	^ (class methodFor: selector) ast
]

{ #category : #transforming }
GtInlineAllSelfSendsRefactoring >> basicTransform [
	| ast |
	ast := self ast.
	ast
		nodesDo: [ :each | 
			| refactoring |
			(each isMessage
				and: [ each receiver isSelfVariable
						and: [ (ignoreSelectors includes: each selector) not
								and: [ (self isRecursiveMethod: each selector in: (Set with: each selector)) not ] ] ])
				ifTrue: [ refactoring := GtInlineMethodRefactoring
							model: model
							inline: each sourceInterval
							inMethod: selector
							forClass: class.
					[ self performCompositeRefactoring: refactoring.
					self mergeVariables.
					^ self basicTransform ] on: Error do: [ :ex | ex return ] ] ].
	self gtCleanupChanges
]

{ #category : #initialization }
GtInlineAllSelfSendsRefactoring >> class: aClass [
	class := self classObjectFor: aClass
]

{ #category : #accessing }
GtInlineAllSelfSendsRefactoring >> ignoreSelectors [
	^ ignoreSelectors
]

{ #category : #accessing }
GtInlineAllSelfSendsRefactoring >> ignoreSelectors: aCollection [
	ignoreSelectors := Set withAll: aCollection
]

{ #category : #initialization }
GtInlineAllSelfSendsRefactoring >> initialize [
	super initialize.
	recursiveMethods := Dictionary new.
	ignoreSelectors := Set new
]

{ #category : #testing }
GtInlineAllSelfSendsRefactoring >> isRecursiveMethod: aSymbol in: aSet [
	((class whoDefinesMethod: aSymbol) ifNotNil: [ :cls | cls methodFor: aSymbol ])
		ifNotNil: [ :method | 
			method ast
				nodesDo: [ :each | 
					(each isMessage
						and: [ each receiver isSelfVariable
								and: [ (ignoreSelectors includes: each selector) not ] ])
						ifTrue: [ (aSet includes: each selector) ifTrue: [ ^ true ].
							aSet add: each selector.
							(self isRecursiveMethod: each selector in: aSet) ifTrue: [ ^ true ].
							aSet remove: each selector ifAbsent: [  ] ] ] ].
	^ false
]

{ #category : #transforming }
GtInlineAllSelfSendsRefactoring >> mergeVariables [
	self ast
		nodesDo: [ :each | 
			(each isAssignment and: [ each value isVariable ])
				ifTrue: [ | refactoring from to |
					each variable name last isDigit
						ifTrue: [ from := each variable.
							to := each value ]
						ifFalse: [ from := each value.
							to := each variable ].
					refactoring := GtMergeVariablesRefactoring
							model: model
							mergeVariableFrom: from sourceInterval
							into: to sourceInterval
							from: selector
							in: class.
					refactoring copyOptionsFrom: self.
					[ refactoring primitiveExecute.
					^ self mergeVariables ] on: Error do: [ :ex | ex return ] ] ]
]

{ #category : #preconditions }
GtInlineAllSelfSendsRefactoring >> preconditions [
	^ RBCondition definesSelector: selector in: class
]

{ #category : #transforming }
GtInlineAllSelfSendsRefactoring >> privateTransform [
	self basicTransform
]

{ #category : #accessing }
GtInlineAllSelfSendsRefactoring >> selector [
	^ selector
]

{ #category : #accessing }
GtInlineAllSelfSendsRefactoring >> selector: anObject [
	selector := anObject
]

{ #category : #transforming }
GtInlineAllSelfSendsRefactoring >> transform [
	self basicTransform
]
