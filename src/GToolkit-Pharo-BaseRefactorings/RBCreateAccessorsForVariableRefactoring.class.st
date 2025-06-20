"
I am a refactoring for creating accessors for variables.

I am used by a couple of other refactorings  creating new variables and accessors.

My precondition is that the variable name is defined for this class.
"
Class {
	#name : #RBCreateAccessorsForVariableRefactoring,
	#superclass : #RBVariableRefactoring,
	#instVars : [
		'getterMethod',
		'setterMethod',
		'classVariable',
		'needsReturn',
		'selector'
	],
	#category : #'GToolkit-Pharo-BaseRefactorings'
}

{ #category : #'instance creation' }
RBCreateAccessorsForVariableRefactoring class >> classVariable: aVarName class: aClass [
	^ self variable: aVarName class: aClass classVariable: true
]

{ #category : #'instance creation' }
RBCreateAccessorsForVariableRefactoring class >> instanceVariable: aVarName class: aClass [
	^ self variable: aVarName class: aClass classVariable: false
]

{ #category : #'instance creation' }
RBCreateAccessorsForVariableRefactoring class >> model: aRBSmalltalk classVariable: aVarName class: aClass [ 

	^ self model: aRBSmalltalk variable: aVarName class: aClass classVariable: true
]

{ #category : #'instance creation' }
RBCreateAccessorsForVariableRefactoring class >> model: aRBSmalltalk instanceVariable: aVarName class: aClass [

	^ self model: aRBSmalltalk variable: aVarName class: aClass classVariable: false
]

{ #category : #'instance creation' }
RBCreateAccessorsForVariableRefactoring class >> model: aRBSmalltalk variable: aVarName class: aClass classVariable: aBoolean [ 
	^(self 
		model: aRBSmalltalk
		variable: aVarName
		class: aClass)
		classVariable: aBoolean;
		yourself
]

{ #category : #'instance creation' }
RBCreateAccessorsForVariableRefactoring class >> variable: aVarName class: aClass classVariable: aBoolean [ 
	^(self variable: aVarName class: aClass)
		classVariable: aBoolean; yourself
]

{ #category : #transforming }
RBCreateAccessorsForVariableRefactoring >> basicTransform [
	self
		createGetterAccessor;
		createSetterAccessor
]

{ #category : #initialization }
RBCreateAccessorsForVariableRefactoring >> classVariable: aBoolean [ 
	classVariable := aBoolean
]

{ #category : #transforming }
RBCreateAccessorsForVariableRefactoring >> createGetterAccessor [

	getterMethod := self findGetterMethod.
	getterMethod ifNil: [ getterMethod := self defineGetterMethod ]
]

{ #category : #transforming }
RBCreateAccessorsForVariableRefactoring >> createMatcher [ 
	^ self parseTreeSearcherClass getterMethod: variableName
]

{ #category : #transforming }
RBCreateAccessorsForVariableRefactoring >> createSetterAccessor [

	setterMethod := self findSetterMethod.
	setterMethod ifNil: [ setterMethod := self defineSetterMethod ]
]

{ #category : #'private - accessing' }
RBCreateAccessorsForVariableRefactoring >> definingClass [
	^ classVariable 
		ifTrue: [ class classSide ]
		ifFalse: [ class ]
]

{ #category : #'private - accessing' }
RBCreateAccessorsForVariableRefactoring >> findGetterMethod [
	| definingClass matcher |
	definingClass := self definingClass.
	matcher := self createMatcher.
	^ self possibleGetterSelectors
		detect: [ :each |
			(self checkClass: definingClass selector: each using: matcher) notNil
				and: [ (definingClass subclassRedefines: each) not ] ]
		ifNone: [ nil ]
]

{ #category : #'private - accessing' }
RBCreateAccessorsForVariableRefactoring >> findSetterMethod [
	| definingClass matcher |
	definingClass := self definingClass.
	matcher := self needsReturnForSetter
		ifTrue: [ self parseTreeSearcherClass returnSetterMethod: variableName ]
		ifFalse: [ self parseTreeSearcherClass setterMethod: variableName ].
	^ self possibleSetterSelectors
		detect: [ :each | 
			(self checkClass: definingClass selector: each using: matcher) notNil
				and: [ (definingClass subclassRedefines: each) not ] ]
		ifNone: [ nil ]
]

{ #category : #'private - accessing' }
RBCreateAccessorsForVariableRefactoring >> getterMethod [
	^getterMethod
]

{ #category : #accessing }
RBCreateAccessorsForVariableRefactoring >> gtDescription [
	^ 'Create accessors for ' , variableName
]

{ #category : #'private - accessing' }
RBCreateAccessorsForVariableRefactoring >> methodsReferencingVariable [
	^classVariable 
		ifTrue: [self definingClass whichSelectorsReferToClassVariable: variableName]
		ifFalse: 
			[self definingClass whichSelectorsReferToInstanceVariable: variableName]
]

{ #category : #testing }
RBCreateAccessorsForVariableRefactoring >> needsReturnForSetter [
	needsReturn
		ifNil:
			[ needsReturn := self usesAssignmentOf: variableName in: class classVariable: classVariable ].
	^ needsReturn
]

{ #category : #'private - accessing' }
RBCreateAccessorsForVariableRefactoring >> possibleGetterSelectors [
	^self methodsReferencingVariable select: [:each | each numArgs == 0]
]

{ #category : #'private - accessing' }
RBCreateAccessorsForVariableRefactoring >> possibleSetterSelectors [
	^self methodsReferencingVariable select: [:each | each numArgs == 1]
]

{ #category : #preconditions }
RBCreateAccessorsForVariableRefactoring >> preconditions [
	^classVariable 
		ifTrue: [RBCondition definesClassVariable: variableName asSymbol in: class]
		ifFalse: [RBCondition definesInstanceVariable: variableName in: class]
]

{ #category : #transforming }
RBCreateAccessorsForVariableRefactoring >> privateTransform [
	self basicTransform
]

{ #category : #transforming }
RBCreateAccessorsForVariableRefactoring >> selector [ 
	^ selector ifNil: [ 
		selector := self safeMethodNameFor: self definingClass
				basedOn: variableName asString. ]
]

{ #category : #'private - accessing' }
RBCreateAccessorsForVariableRefactoring >> setterMethod [
	^setterMethod
]

{ #category : #printing }
RBCreateAccessorsForVariableRefactoring >> storeOn: aStream [ 
	aStream nextPut: $(.
	self class storeOn: aStream.
	aStream nextPutAll: ' variable: '.
	variableName storeOn: aStream.
	aStream nextPutAll: ' class: '.
	class storeOn: aStream.
	aStream nextPutAll: ' classVariable: '.
	classVariable storeOn: aStream.
	aStream nextPut: $)
]

{ #category : #transforming }
RBCreateAccessorsForVariableRefactoring >> transform [
	self basicTransform
]

{ #category : #testing }
RBCreateAccessorsForVariableRefactoring >> usesAssignmentOf: aString in: aClass classVariable: isClassVar [
	| matcher definingClass |
	matcher := self parseTreeSearcher.
	matcher
		answer: false;
		matches: aString , ' := ``@object'
			do: [ :aNode :answer | 
			answer
				or: [ aNode isUsed and: [ aNode methodNode selector ~= aString ] ] ].
	definingClass := isClassVar
		ifTrue: [ aClass instanceSide ]
		ifFalse: [ aClass ].
	^ (definingClass withAllSubclasses
		,
			(isClassVar
				ifTrue: [ definingClass classSide withAllSubclasses ]
				ifFalse: [ #() ])
		anySatisfy: [ :each | 
			((isClassVar
				ifTrue: [ each whichSelectorsReferToClassVariable: aString ]
				ifFalse: [ each whichSelectorsReferToInstanceVariable: aString ])
				anySatisfy:
					[ :sel | self checkClass: each selector: sel using: matcher ]) ])
]
