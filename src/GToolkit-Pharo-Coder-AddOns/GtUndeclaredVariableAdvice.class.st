Class {
	#name : #GtUndeclaredVariableAdvice,
	#superclass : #GtMethodAdvice,
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #testing }
GtUndeclaredVariableAdvice >> canAddInstanceVariable: aString to: aClass [
	(Object includesBehavior: aClass) ifTrue: [ ^ false ].
	^ [ (RBAddInstanceVariableRefactoring variable: aString class: aClass)
		checkPreconditions.
	true ] on: RBRefactoringError do: [ :ex | ex return: false ]
]

{ #category : #accessing }
GtUndeclaredVariableAdvice >> description [
	^ 'Variable is undeclared.'
]

{ #category : #styling }
GtUndeclaredVariableAdvice >> fixItActionsFor: aVariableNode using: aCriticStyler [
	^ aVariableNode variableName first isUppercase
		ifTrue: [ self globalFixItActionsFor: aVariableNode using: aCriticStyler ]
		ifFalse: [ self localFixItActionsFor: aVariableNode using: aCriticStyler ]
]

{ #category : #styling }
GtUndeclaredVariableAdvice >> globalFixItActionsFor: aVariableNode using: aCriticStyler [
	| theFixitActions results |
	theFixitActions := OrderedCollection new.
	theFixitActions
		add: (GtDefineClassFixItAction forCoder: aCriticStyler coderModel node: aVariableNode).

	aCriticStyler isForWorkspace
		ifFalse: [ | aDefineClassAction |
			aDefineClassAction := GtDefineClassVariableFixItAction
					forCoder: aCriticStyler coderModel
					node: aVariableNode.
			theFixitActions add: aDefineClassAction ].

	results := aVariableNode variableName
			correctAgainst: aVariableNode localVariables
			continuedFrom: nil.

	results := aCriticStyler behavior
			possibleVariablesFor: aVariableNode variableName
			continuedFrom: results.

	theFixitActions
		addAll: ((aVariableNode variableName correctAgainst: nil continuedFrom: results)
				collect: [ :each | 
					(GtRenameVariableFixItAction
						forCoder: aCriticStyler coderModel
						node: aVariableNode) newName: each ]).

	^ theFixitActions
]

{ #category : #styling }
GtUndeclaredVariableAdvice >> localFixItActionsFor: aVariableNode using: aCriticStyler [
	| theFixitActions possibleNames |
	theFixitActions := OrderedCollection new.
	theFixitActions
		add: (GtDefineTemporaryFixItAction
				forCoder: aCriticStyler coderModel
				node: aVariableNode).

	(self
		canAddInstanceVariable: aVariableNode variableName
		to: aCriticStyler behavior)
		ifTrue: [ theFixitActions
				add: (GtDefineInstanceVariableFixItAction
						forCoder: aCriticStyler coderModel
						node: aVariableNode) ].
	possibleNames := aVariableNode localVariables
			, aCriticStyler behavior allInstVarNames.

	theFixitActions
		addAll: ((aVariableNode variableName correctAgainst: possibleNames)
				collect: [ :each | 
					(GtRenameVariableFixItAction
						forCoder: aCriticStyler coderModel
						node: aVariableNode) newName: each ]).

	^ theFixitActions
]

{ #category : #testing }
GtUndeclaredVariableAdvice >> matches: aNode from: aCriticRunner [
	aNode isVariable ifFalse: [ ^ false ].
	aNode isUndeclared ifFalse: [ ^ false ].
	(aCriticRunner hasDeclaredVariableNamed: aNode variableName)
		ifTrue: [ ^ false ].
	^ (aCriticRunner hasDeclaredGlobalNamed: aNode variableName) not
]

{ #category : #accessing }
GtUndeclaredVariableAdvice >> name [
	^ 'Reference to undeclared variable'
]
