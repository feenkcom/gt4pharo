Class {
	#name : #GtPushUpMethodRefactoring,
	#superclass : #RBPullUpMethodRefactoring,
	#instVars : [
		'instVarsToPushUp',
		'classObject',
		'targetSuperclassObject'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
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
	| selectorsWithSuperImplementations |
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
								and: [ (class superclass
										includesClass: (method methodClass superclass whoDefinesMethod: impl))
										and: [ (method ast equalTo: (class methodFor: impl) ast exceptForVariables: #()) not ] ] ])
						ifTrue: [ (method ast superMessages includes: impl)
								ifTrue: [ GtRefactoringNotification
										signal: ('<1s>>><2s> senders super <3s> which will call a different implementation than it is currently calling.'
												expandMacrosWith: method methodClass name
												with: method selector
												with: impl) ] ] ] ]
]

{ #category : #initialization }
GtPushUpMethodRefactoring >> initialize [
	super initialize.
	instVarsToPushUp := Set new
]

{ #category : #accessing }
GtPushUpMethodRefactoring >> methodClassName [
	^ class ifNil: [ classObject asString ] ifNotNil: [ class name ]
]

{ #category : #transforming }
GtPushUpMethodRefactoring >> prepareForExecution [
	class := self classObjectFor: classObject.
	targetSuperclass := self classObjectFor: targetSuperclassObject.
	super prepareForExecution
]

{ #category : #transforming }
GtPushUpMethodRefactoring >> privateTransform [
	"P12"
	self pushUpVariables.
	super privateTransform
]

{ #category : #initialization }
GtPushUpMethodRefactoring >> pullUp: selectorCollection from: aClass to: aSuperClass [
	classObject := aClass.
	targetSuperclassObject := aSuperClass.
	selectors := selectorCollection.
	removeDuplicates := false.
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
