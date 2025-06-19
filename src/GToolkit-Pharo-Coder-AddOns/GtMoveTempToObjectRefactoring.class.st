Class {
	#name : #GtMoveTempToObjectRefactoring,
	#superclass : #RBMethodRefactoring,
	#instVars : [
		'selector',
		'temp',
		'newClass',
		'instVar',
		'objectTemp',
		'ast'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #'instance creation' }
GtMoveTempToObjectRefactoring class >> model: aRBModel class: aRBClass selector: aSymbol temp: oldName intoTemp: constructedObjectTemp instVar: newName [
	^ self new
		model: aRBModel;
		class: aRBClass
			selector: aSymbol
			temp: oldName
			intoTemp: constructedObjectTemp
			instVar: newName;
		yourself
]

{ #category : #transforming }
GtMoveTempToObjectRefactoring >> addNewVariableAndAccessors [
	newClass addInstanceVariable: instVar.
	newClass
		compile: ('<1s><n><t>^ <1s>' expandMacrosWith: instVar)
		classified: #accessing.
	newClass
		compile: ('<1s>: anObject<n><t>^ <1s> := anObject' expandMacrosWith: instVar)
		classified: #accessing
]

{ #category : #transforming }
GtMoveTempToObjectRefactoring >> basicTransform [
	self buildAst.
	self validateLifetimes.
	self addNewVariableAndAccessors.
	self changeReferences
]

{ #category : #transforming }
GtMoveTempToObjectRefactoring >> buildAst [
	ast := class parseTreeForSelector: selector
]

{ #category : #transforming }
GtMoveTempToObjectRefactoring >> changeReferences [
	| rewriter |
	rewriter := RBParseTreeRewriter new.
	(self isForSelf not
		and: [ self findVariableToMove
				ifNil: [ false ]
				ifNotNil: [ :node | node parent isSequence ] ])
		ifFalse: [ rewriter
				replace: objectTemp , ' := ' , newClass name , ' new'
				with: objectTemp , ' := ' , newClass name , ' new ' , instVar , ': ' , temp
						, '; yourself'.
			rewriter
				replace: objectTemp , ' := ' , newClass name , ' new `@;cascades; yourself'
				with: objectTemp , ' := ' , newClass name , ' new `@;cascades;' , instVar , ': '
						, temp , '; yourself' ].
	rewriter replace: temp , ' := ``@a' with: objectTemp , ' ' , instVar , ': ``@a'.
	rewriter replace: temp with: objectTemp , ' ' , instVar.
	(rewriter executeTree: ast) ifTrue: [ class compileTree: rewriter tree ]
]

{ #category : #transforming }
GtMoveTempToObjectRefactoring >> checkConstructor: aNode [
	aNode isMessage
		ifTrue: [ (#(new basicNew new: basicNew:) includes: aNode selector)
				ifTrue: [ self checkVariableIsForClass: aNode receiver.
					^ self ] ].
	aNode isCascade
		ifTrue: [ aNode messages last selector = #yourself
				ifTrue: [ self checkConstructor: aNode receiver.
					^ self ] ].
	self
		refactoringError: 'Cannot determine if ' , objectTemp , ' is assigned a newly constructed object'
]

{ #category : #transforming }
GtMoveTempToObjectRefactoring >> checkVariableIsForClass: aNode [
	aNode isVariable
		ifTrue: [ (self model classNamed: aNode name asSymbol)
				ifNotNil: [ :cls | 
					newClass := cls.
					^ self ] ].
	self refactoringError: aNode formattedCode , ' isn''t a class'
]

{ #category : #initialization }
GtMoveTempToObjectRefactoring >> class: aRBClass selector: aSymbol temp: oldName intoTemp: constructedObjectTemp instVar: newName [ 
	class := aRBClass.
	selector := aSymbol.
	temp := oldName.
	objectTemp := constructedObjectTemp.
	instVar := newName
]

{ #category : #transforming }
GtMoveTempToObjectRefactoring >> findVariable: aString [
	ast
		nodesDo: [ :each | 
			(each isBlock or: [ each isMethod ])
				ifTrue: [ (each arguments detect: [ :arg | arg name = aString ] ifNone: [  ])
						ifNotNil: [ :arg | ^ arg ] ].
			each isSequence
				ifTrue: [ (each temporaries detect: [ :arg | arg name = aString ] ifNone: [  ])
						ifNotNil: [ :arg | ^ arg ] ] ].
	self canSplitLifetimes ifTrue: [ ^ nil ].
	self refactoringError: 'Could not find ' , aString , ' in the method'
]

{ #category : #transforming }
GtMoveTempToObjectRefactoring >> findVariableForConstructedObject [
	| var assignmentCount |
	var := self findVariable: objectTemp.
	assignmentCount := 0.
	var parent
		nodesDo: [ :each | 
			(each isAssignment and: [ each variable = var ])
				ifTrue: [ self checkConstructor: each value.
					assignmentCount := assignmentCount + 1 ] ].
	assignmentCount ~= 1
		ifTrue: [ self refactoringError: objectTemp , ' should be assigned only once' ].
	^ var
]

{ #category : #transforming }
GtMoveTempToObjectRefactoring >> findVariableToMove [
	^ self findVariable: temp
]

{ #category : #transforming }
GtMoveTempToObjectRefactoring >> isForSelf [
	^ temp = 'self'
]

{ #category : #preconditions }
GtMoveTempToObjectRefactoring >> preconditions [
	^ RBCondition empty
]

{ #category : #transforming }
GtMoveTempToObjectRefactoring >> privateTransform [
	self basicTransform
]

{ #category : #transforming }
GtMoveTempToObjectRefactoring >> transform [
	self basicTransform
]

{ #category : #transforming }
GtMoveTempToObjectRefactoring >> validate: variableToMove isAssignedAfter: objectVariable [
	| firstAssignment objectAssignment |
	firstAssignment := SmallInteger maxVal - 1.
	ast
		nodesDo: [ :each | 
			each isAssignment
				ifTrue: [ each variable = objectVariable ifTrue: [ objectAssignment := each stop ].
					(each variable = variableToMove and: [ each start < firstAssignment ])
						ifTrue: [ firstAssignment := each start ] ] ].
	objectAssignment > firstAssignment
		ifTrue: [ self refactoringError: temp , ' is assigned before ' , objectTemp ]
]

{ #category : #transforming }
GtMoveTempToObjectRefactoring >> validateLifetimes [
	| variableToMove objectVariable |
	objectVariable := self findVariableForConstructedObject.
	self isForSelf ifTrue: [ ^ self ].
	self canSplitLifetimes ifTrue: [ ^ self ].
	variableToMove := self findVariableToMove.
	objectVariable parent = variableToMove parent
		ifTrue: [ self validate: variableToMove isAssignedAfter: objectVariable ]
		ifFalse: [ objectVariable parent parent = variableToMove parent ifTrue: [ ^ self ] ].
	self
		refactoringError: temp , ' and ' , objectTemp , ' do not have the same lifetimes'
]
