Class {
	#name : #GtExtractSuperclassRefactoring,
	#superclass : #RBClassRefactoring,
	#instVars : [
		'superclass',
		'subclasses',
		'category'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #'instance creation' }
GtExtractSuperclassRefactoring class >> addClass: aName superclass: aClass subclasses: aCollection category: aSymbol [
	^ (self className: aName)
		superclass: aClass;
		subclasses: aCollection;
		category: aSymbol;
		yourself
]

{ #category : #'instance creation' }
GtExtractSuperclassRefactoring class >> model: aRBSmalltalk addClass: aName superclass: aClass subclasses: aCollection category: aSymbol [
	^ (self model: aRBSmalltalk className: aName)
		superclass: aClass;
		subclasses: aCollection;
		category: aSymbol;
		yourself
]

{ #category : #transforming }
GtExtractSuperclassRefactoring >> basicTransform [
	self createNewClass.
	self pullUpCommonVariables.
	self pullUpCommonMethods.
	self createSubclassResponsibilityMethods
]

{ #category : #accessing }
GtExtractSuperclassRefactoring >> category [
	^ category
]

{ #category : #accessing }
GtExtractSuperclassRefactoring >> category: anObject [
	category := anObject
]

{ #category : #accessing }
GtExtractSuperclassRefactoring >> createNewClass [
	self
		performCompositeRefactoring: (RBAddClassRefactoring
				model: self model
				addClass: className
				superclass: superclass
				subclasses: subclasses
				category: category)
]

{ #category : #transforming }
GtExtractSuperclassRefactoring >> createSubclassResponsibilityMethods [
	| newClass |
	newClass := model classNamed: className.
	self createSubclassResponsibilityMethods: newClass.
	self createSubclassResponsibilityMethods: newClass classSide
]

{ #category : #transforming }
GtExtractSuperclassRefactoring >> createSubclassResponsibilityMethods: aClass [
	| selectors |
	selectors := Bag new.
	aClass subclasses do: [ :each | selectors addAll: each selectors ].
	selectors
		doWithOccurrences: [ :each :count | 
			(count = subclasses size and: [ (aClass definesMethod: each) not ])
				ifTrue: [ | ast method |
					method := aClass subclasses first methodFor: each.
					ast := method ast copy.
					ast
						body: (RBSequenceNode
								statements: {RBReturnNode
											value: (RBMessageNode
													receiver: (RBVariableNode named: 'self')
													selector: #subclassResponsibility)}).
					self
						performCompositeRefactoring: (GtRBAddMethodRefactoring
								model: self model
								addMethod: ast formattedCode
								toClass: aClass
								inProtocols: method protocols) ] ]
]

{ #category : #accessing }
GtExtractSuperclassRefactoring >> gtDescription [
	^ 'Extract superclass ' , className
]

{ #category : #preconditions }
GtExtractSuperclassRefactoring >> preconditions [
	"handled by component refactorings"

	^ RBCondition true
]

{ #category : #transforming }
GtExtractSuperclassRefactoring >> privateTransform [
	self basicTransform
]

{ #category : #transforming }
GtExtractSuperclassRefactoring >> pullUpCommonInstanceVariables: aClass [
	| vars |
	vars := Bag new.
	aClass subclasses do: [ :each | vars addAll: each instanceVariableNames ].
	vars
		doWithOccurrences: [ :each :count | 
			count = subclasses size
				ifTrue: [ self
						performCompositeRefactoring: (RBPullUpInstanceVariableRefactoring
								model: self model
								variable: each
								class: aClass) ] ]
]

{ #category : #transforming }
GtExtractSuperclassRefactoring >> pullUpCommonMethods [
	| newClass |
	newClass := model classNamed: className.
	self pullUpCommonMethods: newClass.
	self pullUpCommonMethods: newClass classSide
]

{ #category : #transforming }
GtExtractSuperclassRefactoring >> pullUpCommonMethods: aClass [
	| selectors selectorsToPullUp classVarSelectors |
	selectorsToPullUp := Set new.
	selectors := Bag new.
	aClass subclasses do: [ :each | selectors addAll: each selectors ].
	selectors
		doWithOccurrences: [ :each :count | 
			count = subclasses size
				ifTrue: [ | method ast |
					classVarSelectors
						ifNil: [ classVarSelectors := Set new.
							aClass subclasses first instanceSide classVariableNames
								do: [ :cv | 
									classVarSelectors
										addAll: (aClass subclasses first whichSelectorsReferToClassVariable: cv) ] ].
					(classVarSelectors includes: each)
						ifFalse: [ method := aClass subclasses first methodFor: each.
							ast := method ast.
							(aClass subclasses allSatisfy: [ :cls | (cls methodFor: each) ast = ast ])
								ifTrue: [ selectorsToPullUp add: each ] ] ] ].
	selectorsToPullUp notEmpty
		ifTrue: [ self
				performCompositeRefactoring: ((GtPushUpMethodRefactoring
						model: self model
						pullUp: selectorsToPullUp
						from: aClass subclasses first)
						gtDefaultToRemoveDuplicates;
						yourself) ]
]

{ #category : #transforming }
GtExtractSuperclassRefactoring >> pullUpCommonVariables [
	| newClass |
	newClass := model classNamed: className.
	self pullUpCommonInstanceVariables: newClass.
	self pullUpCommonInstanceVariables: newClass classSide
]

{ #category : #accessing }
GtExtractSuperclassRefactoring >> subclasses [
	^ subclasses
]

{ #category : #accessing }
GtExtractSuperclassRefactoring >> subclasses: anObject [
	subclasses := anObject
]

{ #category : #accessing }
GtExtractSuperclassRefactoring >> superclass [
	^ superclass
]

{ #category : #accessing }
GtExtractSuperclassRefactoring >> superclass: anObject [
	superclass := anObject
]

{ #category : #transforming }
GtExtractSuperclassRefactoring >> transform [
	self basicTransform
]
