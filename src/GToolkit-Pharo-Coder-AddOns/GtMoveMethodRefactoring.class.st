Class {
	#name : #GtMoveMethodRefactoring,
	#superclass : #RBMoveMethodRefactoring,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #accessing }
GtMoveMethodRefactoring >> checkAssignmentsToVariable [
	self isExpression ifFalse: [ super checkAssignmentsToVariable ]
]

{ #category : #transforming }
GtMoveMethodRefactoring >> checkTemporaryVariableNames [
	self shouldRenameTemps ifTrue: [ ^ self ].
	^ super checkTemporaryVariableNames
]

{ #category : #transforming }
GtMoveMethodRefactoring >> compileNewMethods [
	| newSource |
	newSource := self movedAST newSource.
	moveToClasses
		do: [ :each | each compile: newSource withAttributesFrom: (class methodFor: selector) ]
]

{ #category : #accessing }
GtMoveMethodRefactoring >> getClassesForInstanceVariable [
	| definingClass typer types |
	definingClass := class whoDefinesInstanceVariable: variable.
	typer := GtRefactoryTyper newFor: self model.
	types := typer guessTypesFor: variable in: definingClass.
	types
		ifEmpty: [ types := OrderedCollection with: (self model classNamed: #Object) ].
	moveToClasses := self selectVariableTypesFrom: types selected: types copy.
	moveToClasses ifNil: [ self refactoringFailure: 'Method not moved' ]
]

{ #category : #'private - accessing' }
GtMoveMethodRefactoring >> getClassesForTemporaryVariable [
	"Same as superclass but using GtRefactoryTyper instead"

	| types |
	types := GtRefactoryTyper
			typesFor: variable
			in: parseTree
			model: self model.
	types
		ifEmpty: [ types := OrderedCollection with: (self model classNamed: #Object) ].
	moveToClasses := self selectVariableTypesFrom: types selected: types.
	moveToClasses ifNil: [ self refactoringFailure: 'Method not moved' ]
]

{ #category : #accessing }
GtMoveMethodRefactoring >> getClassesToMoveTo [
	moveToClasses := (self options
			at: #variableTypesForReceiver
			ifAbsent: [ [ :ref :block | block value ] ])
			cull: self
			cull: [ self isExpression
					ifTrue: [ | ast |
						ast := RBParser parseExpression: variable.
						moveToClasses := {self model
									classNamed: ((ast isMessage and: [ ast selector = #new and: [ ast receiver isVariable ] ])
											ifTrue: [ ast receiver name ]
											ifFalse: [ #Object ])} ]
					ifFalse: [ super getClassesToMoveTo ].
				moveToClasses ]
]

{ #category : #accessing }
GtMoveMethodRefactoring >> getNewMethodName [
	"Copied from superclass to change how overriding selectors work."

	| newSelector parameters methodName newMethodName |
	self removeArgument.
	parameters := parseTree argumentNames asOrderedCollection.	"parameters remove: variable ifAbsent: []."
	self needsToReplaceSelfReferences ifTrue: [ parameters add: selfVariableName ].
	methodName := RBMethodName
			selector: (self uniqueMethodNameFor: parameters size)
			arguments: parameters.

	[ newMethodName := self requestMethodNameFor: methodName.
	newMethodName ifNil: [ self refactoringFailure: 'Did not move method' ].
	newMethodName isValid
		ifTrue: [ newSelector := newMethodName selector ]
		ifFalse: [ self refactoringWarning: 'Invalid method name' ].
	parameters := newMethodName arguments.
	(self checkMethodName: newSelector in: class)
		ifFalse: [ self refactoringWarning: newSelector , ' is not a valid selector name.'.
			newSelector := nil ].
	moveToClasses
		detect: [ :move | 
			(model allImplementorsOf: newSelector)
				anySatisfy: [ :each | (move includesClass: each) or: [ each includesClass: move ] ] ]
		ifFound: [ :hierarchyClass | 
			(self gtSignalMethodOverwritten: newSelector in: hierarchyClass)
				ifFalse: [ self refactoringError: newSelector , ' is already defined in the hierarchy' ] ].
	newSelector isNil ] whileTrue.
	parseTree
		renameSelector: newSelector
		andArguments: (parameters collect: [ :each | RBVariableNode named: each ]) asArray
]

{ #category : #accessing }
GtMoveMethodRefactoring >> isExpression [
	^ (RBScanner isVariable: variable) not
]

{ #category : #accessing }
GtMoveMethodRefactoring >> moveToClasses [
	^ moveToClasses
]

{ #category : #transforming }
GtMoveMethodRefactoring >> movedAST [
	| varNames varsToRename ast |
	self shouldRenameTemps ifFalse: [ ^ parseTree ].
	ast := parseTree copy.
	varNames := ast allDefinedVariables.
	selfVariableName ifNotNil: [ varNames add: selfVariableName ].
	varsToRename := varNames
			select: [ :name | moveToClasses anySatisfy: [ :each | self canReferenceVariable: name in: each ] ].
	varsToRename
		do: [ :each | 
			| newName |
			newName := (((each beginsWith: 'an')
					ifTrue: [ each at: 3 ifAbsent: [  ] ]
					ifFalse: [ each first = $a ifTrue: [ each at: 2 ifAbsent: [  ] ] ])
					ifNotNil: [ :c | c isUppercase ifTrue: [ '_' , each ] ])
					ifNil: [ (each first isVowel ifTrue: [ 'an' ] ifFalse: [ 'a' ]) , each capitalized ].
			ast
				nodesDo: [ :node | 
					(node isVariable and: [ node name = each ])
						ifTrue: [ node replaceWith: (RBVariableNode named: newName) ] ] ].
	^ ast
]

{ #category : #accessing }
GtMoveMethodRefactoring >> movedSelector [
	^ parseTree selector
]

{ #category : #transforming }
GtMoveMethodRefactoring >> shouldRenameTemps [
	^ (self options at: #renameTemporaries ifAbsent: [ [ false ] ]) cull: self
]
