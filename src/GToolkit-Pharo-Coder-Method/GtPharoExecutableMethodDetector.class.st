Class {
	#name : #GtPharoExecutableMethodDetector,
	#superclass : #Object,
	#instVars : [
		'methodCoder',
		'methodAst',
		'methodCoderViewModel',
		'isExecutable'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Utilities'
}

{ #category : #private }
GtPharoExecutableMethodDetector >> beExecutable [
	isExecutable := true
]

{ #category : #private }
GtPharoExecutableMethodDetector >> beNotExecutable [
	isExecutable := false
]

{ #category : #building }
GtPharoExecutableMethodDetector >> detect [
	self beNotExecutable.
	methodCoder compiledMethod ifNil: [ ^ self ].

	self isUnaryInstanceSideMethod ifTrue: [ ^ self beExecutable ].
	self isUnaryClassSideMethod ifTrue: [ ^ self beExecutable ].
	self isMethodWithArgumentBindings ifTrue: [ ^ self beExecutable ].
]

{ #category : #building }
GtPharoExecutableMethodDetector >> ifExecutable: aBlock [
	isExecutable ifNil: [ self detect ].
	^ isExecutable ifTrue: aBlock
]

{ #category : #building }
GtPharoExecutableMethodDetector >> ifNotExecutable: aBlock [
	isExecutable ifNil: [ self detect ].
	^ isExecutable ifFalse: aBlock
]

{ #category : #building }
GtPharoExecutableMethodDetector >> isMethodWithArgumentBindings [
	| aContext argumentNames |
	aContext := methodCoderViewModel evaluationContext.
	argumentNames := methodCoder compiledMethod argumentNames.
	argumentNames ifEmpty: [ ^ false ].
	^ argumentNames
		allSatisfy: [ :aName | 
			aContext bindingStrategy
				bindingValueOf: aName
				ifPresent: [ :aValue | true ]
				ifAbsent: [ false ] ]
]

{ #category : #private }
GtPharoExecutableMethodDetector >> isUnaryClassSideMethod [
	^ methodAst notNil
		and: [ methodAst methodNode
				ifNotNil: [ :node | 
					node variables isEmpty
						and: [ methodCoder compiledMethod methodClass isClassSide ] ]
				ifNil: [ false ] ]
]

{ #category : #private }
GtPharoExecutableMethodDetector >> isUnaryInstanceSideMethod [
	^ methodCoderViewModel selfObject notNil
		and: [ methodAst methodNode isNotNil
			and: [ methodAst methodNode selector isNotNil
					and: [ methodAst methodNode selector isUnary ] ] ]
]

{ #category : #accessing }
GtPharoExecutableMethodDetector >> methodAst [
	^ methodAst
]

{ #category : #accessing }
GtPharoExecutableMethodDetector >> methodAst: anObject [
	methodAst := anObject
]

{ #category : #accessing }
GtPharoExecutableMethodDetector >> methodCoder [
	^ methodCoder
]

{ #category : #accessing }
GtPharoExecutableMethodDetector >> methodCoder: anObject [
	methodCoder := anObject
]

{ #category : #accessing }
GtPharoExecutableMethodDetector >> methodCoderViewModel [
	^ methodCoderViewModel
]

{ #category : #accessing }
GtPharoExecutableMethodDetector >> methodCoderViewModel: anObject [
	methodCoderViewModel := anObject
]
