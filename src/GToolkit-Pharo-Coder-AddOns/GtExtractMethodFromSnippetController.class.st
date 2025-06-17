"
nil
"
Class {
	#name : #GtExtractMethodFromSnippetController,
	#superclass : #GtExtractMethodToComponentController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #private }
GtExtractMethodFromSnippetController >> boundReceiverValueFor: aString [
	(sourceCoderViewModel compositeVariableBindings hasBindingOf: aString)
		ifTrue: [ (sourceCoderViewModel compositeVariableBindings bindingValueOf: aString)
				ifNotNil: [ :value | ^ value ] ].
	(sourceCoderViewModel behavior bindingOf: aString) value
		ifNotNil: [ :value | ^ value ].
	^ sourceCoderViewModel selfObject
		ifNotNil: [ :value | 
			value class
				slotNamed: aString
				ifFound: [ :slot | slot read: self ]
				ifNone: [  ] ]
]

{ #category : #executing }
GtExtractMethodFromSnippetController >> createModel [
	| model |
	model := Smalltalk createRbNamespace onEnvironment: RBBrowserEnvironment new.
	model name: self refactoringName.
	^ model
]

{ #category : #accessing }
GtExtractMethodFromSnippetController >> finishRefactoring: refactoring [
	| newText |
	super finishRefactoring: refactoring.
	newText := refactoring snippetSource asRopedText glamorousCodeFontAndSize.
	self sourceCoderViewModel
		sourceText: newText asRopedText
		from: self
		synchronously: false
]

{ #category : #private }
GtExtractMethodFromSnippetController >> getReceiverVariableFor: cls selector: sel [
	| ast |
	(receiver notNil and: [ receiver ~= 'self' or: [ self isForInspector ] ])
		ifTrue: [ ^ receiver ].
	ast := (cls methodFor: sel) ast.
	ast arguments isEmpty
		ifTrue: [ ast
				nodesDo: [ :each | 
					(each isVariable and: [ Smalltalk globals includesKey: each name asSymbol ])
						ifTrue: [ ^ receiver := each name ] ].
			^ receiver := #Object ].
	^ receiver := (ast arguments
			detect: [ :each | (self boundReceiverValueFor: each name) notNil ]
			ifNone: [ ast arguments first ]) name
]

{ #category : #private }
GtExtractMethodFromSnippetController >> getTypeForReceiverFor: aRefactoring from: types [
	| classes |
	receiverClassName
		ifNotNil: [ ^ {aRefactoring model classNamed: receiverClassName} ].
	classes := types reject: [ :e | e isTrait ].
	potentialTypes := GtPrefixTree
			withAll: (classes collect: [ :each | self typeNameFor: each ]).
	classes size = 1
		ifTrue: [ receiverClassName := self typeNameFor: classes anyOne ].
	^ {aRefactoring model classNamed: self receiverClassName}
]

{ #category : #private }
GtExtractMethodFromSnippetController >> getTypeForReceiverIn: aModel [
	^ (self boundReceiverValueFor: receiver)
		ifNotNil: [ :value | 
			| class |
			class := value class.
			{Boolean.
				Symbol.
				Integer.
				Float} do: [ :each | (class inheritsFrom: each) ifTrue: [ class := each ] ].
			((class inheritsFrom: String) and: [ class ~= Symbol ])
				ifTrue: [ class := String ].
			{aModel classFor: class} ]
]

{ #category : #private }
GtExtractMethodFromSnippetController >> isForInspector [
	^ sourceCoderViewModel behavior ~= nil class
]

{ #category : #private }
GtExtractMethodFromSnippetController >> parserStartingState [
	^ GtPharoParser startingStateForMethodSequence
]

{ #category : #accessing }
GtExtractMethodFromSnippetController >> potentialReceivers [
	| names |
	potentialReceivers ifNotNil: [ ^ potentialReceivers ].
	names := super potentialReceivers.
	receiver ~= 'self'
		ifTrue: [ (names includes: receiver)
				ifTrue: [ names remove: 'self' ]
				ifFalse: [ names at: (names indexOf: 'self') put: receiver ] ].
	self isForInspector
		ifFalse: [ sourceCoderViewModel behavior allClassVarNames
				do: [ :each | names remove: each ifAbsent: [  ] ] ].
	^ names
]

{ #category : #executing }
GtExtractMethodFromSnippetController >> refactoring [
	| refactoring |
	(self isForInspector not or: [ receiver ~= 'self' ])
		ifTrue: [ refactoring := GtExtractMethodFromSnippetRefactoring
					extract: self extractionInterval
					from: originalSource.
			refactoring
				setOption: #selfArgumentName toUse: [ :ref | self selfArgumentName ];
				setOption: #selectVariableToMoveTo
					toUse: [ :ref :cls :sel | self getReceiverVariableFor: cls selector: sel ];
				setOption: #variableTypesForReceiver
					toUse: [ :ref :block | 
						| classes |
						classes := (self getTypeForReceiverIn: ref model) ifNil: block.
						self getTypeForReceiverFor: ref from: classes ];
				setOption: #variableTypes
					toUse: [ :ref :types :selected | self getTypeForReceiverFor: ref from: types ] ]
		ifFalse: [ refactoring := GtExtractMethodFromInspectorRefactoring
					extract: self extractionInterval
					from: originalSource
					in: sourceCoderViewModel behavior ].
	^ refactoring
]

{ #category : #private }
GtExtractMethodFromSnippetController >> typeNameFor: aRBClass [
	^ (aRBClass name , (aRBClass isMeta ifTrue: [ ' class' ] ifFalse: [ '' ])) asSymbol
]

{ #category : #accessing }
GtExtractMethodFromSnippetController >> updateFromRefactoring: aRefactoring [
	| newSource |
	self updateExtractedMethodSourceFrom: aRefactoring.
	self resetNewSelectorIfNeeded.
	newSource := aRefactoring snippetSource.
	self updateMethod: newSource
]
