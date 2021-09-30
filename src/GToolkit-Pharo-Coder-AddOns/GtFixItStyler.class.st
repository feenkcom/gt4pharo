Class {
	#name : #GtFixItStyler,
	#superclass : #GtGenericPharoStyler,
	#instVars : [
		'isForWorkspace',
		'hasRefactoring',
		'variableBindings'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-FixIt'
}

{ #category : #'private - variables' }
GtFixItStyler >> canAddInstanceVariable: aString to: aClass [
	(Object includesBehavior: aClass)
		ifTrue: [ ^ false ].
	^ [ (RBAddInstanceVariableRefactoring variable: aString class: aClass)
		checkPreconditions.
	true ]
		on: RBRefactoringError
		do: [ :ex | ex return: false ]
]

{ #category : #'private - variables' }
GtFixItStyler >> fixItActionsForVariable: aVariableNode [
	^ aVariableNode variableName first isUppercase
		ifTrue: [ self globalFixItActionsFor: aVariableNode ]
		ifFalse: [ self localFixItActionsFor: aVariableNode ]
]

{ #category : #'private - variables' }
GtFixItStyler >> globalFixItActionsFor: aVariableNode [
	| theFixitActions results |

	theFixitActions := OrderedCollection new.
	theFixitActions add: (GtDefineClassFixItAction forCoder: self sourceCoder node: aVariableNode).

	isForWorkspace
		ifFalse: [
			| aDefineClassAction |
			aDefineClassAction := GtDefineClassVariableFixItAction
				forCoder: self sourceCoder
				node: aVariableNode.
			theFixitActions add: aDefineClassAction ].

	results := aVariableNode variableName
		correctAgainst: aVariableNode localVariables
		continuedFrom: nil.

	results := self sourceCoder behavior
		possibleVariablesFor: aVariableNode variableName
		continuedFrom: results.

	theFixitActions addAll: ((aVariableNode variableName correctAgainst: nil continuedFrom: results)
		collect: [ :each | 
			(GtRenameVariableFixItAction
				forCoder: self sourceCoder
				node: aVariableNode)
					newName: each ]).

	^ theFixitActions
]

{ #category : #testing }
GtFixItStyler >> hasRefactoring [
	hasRefactoring
		ifNotNil: [ ^ hasRefactoring ].
		
	^ hasRefactoring := text hasAttributeSuchThat: [ :eachAttribute |
		eachAttribute isKindOf: GtRefactoringChangesAttribute ]
]

{ #category : #accessing }
GtFixItStyler >> initialize [
	super initialize.

	isForWorkspace := false
]

{ #category : #accessing }
GtFixItStyler >> isForWorkspace: aBoolean [
	isForWorkspace := aBoolean
]

{ #category : #'private - variables' }
GtFixItStyler >> localFixItActionsFor: aVariableNode [
	| theFixitActions possibleNames |

	theFixitActions := OrderedCollection new.
	theFixitActions add:
		(GtDefineTemporaryFixItAction
			forCoder: self sourceCoder
			node: aVariableNode).
	
	(self
		canAddInstanceVariable: aVariableNode variableName
		to: self sourceCoder behavior)
		ifTrue: [
			theFixitActions add:
				(GtDefineInstanceVariableFixItAction
					forCoder: self sourceCoder
					node: aVariableNode) ].
	possibleNames := aVariableNode localVariables, self sourceCoder behavior allInstVarNames.

	theFixitActions addAll: ((aVariableNode variableName correctAgainst: possibleNames)
		collect: [ :each | 
			(GtRenameVariableFixItAction
				forCoder: self sourceCoder
				node: aVariableNode) newName: each ]).

	^ theFixitActions
]

{ #category : #accessing }
GtFixItStyler >> sourceCoder [
	^ self coderViewModel coderModel
]

{ #category : #'api - styling' }
GtFixItStyler >> style: aText ast: theAst [
	hasRefactoring := nil.
	variableBindings := self coderViewModel compositeVariableBindings.
	[ super style: aText ast: theAst ]
		ensure: [ variableBindings := nil ]
]

{ #category : #'private - messages' }
GtFixItStyler >> typeOf: aGtPharoProgramNode [
	^ GtPharoProgramNode
		typeOf: aGtPharoProgramNode
		in: (isForWorkspace
			ifTrue: [ self coderViewModel selfObject class ]
			ifFalse: [ self sourceCoder behavior ])
		bindings: variableBindings
]

{ #category : #visiting }
GtFixItStyler >> visitMessageSend: aNode [
	| hasActiveRefactoring theNodeType theClassForSelector attribute |
	super visitMessageSend: aNode.

	hasActiveRefactoring := BlTextStylerTelemetry
		timeSync: [ 'Has refactoring?' ]
		during: [ self hasRefactoring ].

	hasActiveRefactoring
		ifTrue: [ ^ self ].

	theNodeType := BlTextStylerTelemetry
		timeSync: [ 'Type of ', aNode receiver source asString, ' in ', self sourceCoder behavior name ]
		during: [ self typeOf: aNode receiver ].

	theNodeType
		ifNil: [ ^ self ].
		
	theClassForSelector := BlTextStylerTelemetry
		timeSync: [ 'Which superclass of ', theNodeType name, ' includes ', aNode selector printString ]
		during: [ theNodeType whichClassIncludesSelector: aNode selector ].

	theClassForSelector
		ifNotNil: [ ^ self ].

	(theNodeType isTrait
		and: [ (Object whichClassIncludesSelector: aNode selector) notNil ])
			ifTrue: [ ^ self ].

	attribute := GtFixItAttribute new.
	attribute fixItActions: [ {
		(GtDefineMethodFixItAction forCoder: self sourceCoder node: aNode)
			classOrMetaClass: theNodeType
		} ].
	
	self
		attribute: attribute
		from: aNode selectorParts last stopPosition
		to: aNode selectorParts last stopPosition
]

{ #category : #visiting }
GtFixItStyler >> visitMethod: aMethodNode [
	aMethodNode selectorDo: [ :aSelector |
		aSelector isDoIt
			ifTrue: [ ^ self ] ].

	^ super visitMethod: aMethodNode
]

{ #category : #visiting }
GtFixItStyler >> visitVariable: aVariableNode [
	| isUndeclared anAttribute |

	isUndeclared := aVariableNode isUndeclared.
	isUndeclared
		ifFalse: [ ^ self ].

	(self coderViewModel hasDeclaredVariableNamed: aVariableNode variableName)
		ifTrue: [ ^ self ].
		
	(self coderViewModel hasDeclaredGlobalNamed: aVariableNode variableName)
		ifTrue: [ ^ self ].

	anAttribute := GtFixItAttribute new.
	anAttribute fixItActions: [ self fixItActionsForVariable: aVariableNode ].
	self
		attribute: anAttribute
		from: aVariableNode name stopPosition
		to: aVariableNode name stopPosition.

	super visitVariable: aVariableNode
]
