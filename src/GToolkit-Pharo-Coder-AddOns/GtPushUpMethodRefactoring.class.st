Class {
	#name : #GtPushUpMethodRefactoring,
	#superclass : #RBPullUpMethodRefactoring,
	#instVars : [
		'instVarsToPushUp'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #preconditions }
GtPushUpMethodRefactoring >> checkInstVars [
	super checkInstVars.
	instVarsToPushUp notEmpty
		ifTrue: [ GtRefactoringNotification
				signal: (String
						streamContents: [ :stream | 
							instVarsToPushUp size = 1
								ifTrue: [ stream << 'Instance variable, ' << instVarsToPushUp any
										<< ', is referenced in the method to push up. Continuing will push up the instance variable too.' ]
								ifFalse: [ stream << instVarsToPushUp size printString
										<< ' instance variables are referenced in the method to push up. Continuing will push up the instance variables too.' ] ]) ]
]

{ #category : #preconditions }
GtPushUpMethodRefactoring >> checkInstVarsFor: aSelector [
	class instanceVariableNames
		do: [ :each | 
			((class whichSelectorsReferToInstanceVariable: each) includes: aSelector)
				ifTrue: [ instVarsToPushUp add: each ] ]
]

{ #category : #preconditions }
GtPushUpMethodRefactoring >> checkSuperSendsFromSiblings [
	| selectorsWithSuperImplementations definer |
	targetSuperclass subclasses size <= 1 ifTrue: [ ^ self ].
	selectorsWithSuperImplementations := selectors
			select: [ :each | class superclass definesMethod: each ].
	selectorsWithSuperImplementations isEmpty ifTrue: [ ^ self ].
	selectorsWithSuperImplementations
		do: [ :impl | 
			self model
				allReferencesTo: impl
				do: [ :method | 
					((method methodClass includesClass: class) not
						and: [ (method methodClass includesClass: class superclass)
								and: [ class superclass
										includesClass: (definer := method methodClass superclass whoDefinesMethod: impl) ] ])
						ifTrue: [ (method ast superMessages includes: impl)
								ifTrue: [ self
										refactoringError: ('Cannot push up <1s> since it would override the method defined in <2p>'
												expandMacrosWith: impl
												with: definer) ] ] ] ]
]

{ #category : #initialization }
GtPushUpMethodRefactoring >> initialize [
	super initialize.
	instVarsToPushUp := Set new
]

{ #category : #transforming }
GtPushUpMethodRefactoring >> privateTransform [
	"P12"
	self pushUpVariables.
	super privateTransform
]

{ #category : #initialization }
GtPushUpMethodRefactoring >> pullUp: selectorCollection from: aClass to: aSuperClass [
	super pullUp: selectorCollection from: aClass to: aSuperClass.
	removeDuplicates := true
]

{ #category : #transforming }
GtPushUpMethodRefactoring >> pushUpVariables [
	instVarsToPushUp
		do: [ :each | 
			self
				performCompositeRefactoring: (RBPullUpInstanceVariableRefactoring
						model: self model
						variable: each
						class: class superclass) ]
]

{ #category : #transforming }
GtPushUpMethodRefactoring >> transform [
	"P11"
	self pushUpVariables.
	super transform
]
