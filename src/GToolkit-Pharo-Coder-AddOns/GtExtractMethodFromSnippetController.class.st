Class {
	#name : #GtExtractMethodFromSnippetController,
	#superclass : #GtExtractMethodController,
	#instVars : [
		'receiverVariable',
		'selector'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #adding }
GtExtractMethodFromSnippetController >> addReorderParametersAttributesOn: message [
	| attribute |
	message isUnary ifTrue: [ ^ self ].
	moveAttributes := OrderedCollection new.
	attribute := GtExtractMethodReorderParametersAttribute
		action: [ self swapParameterWithNext: 0 ]
		icon: BrGlamorousVectorIcons right.
	moveAttributes add: attribute.
	self sourceCoderViewModel
		addTextAttribute: attribute
		from: message parent receiver stopPosition
		to: message parent receiver stopPosition.
	(message isBinary ifTrue: [ {message value} ] ifFalse: [ message values ])
		keysAndValuesDo:
			[ :i :each | 
			attribute := GtExtractMethodReorderParametersAttribute
				action: [ self swapParameterWithNext: i - 1 ]
				icon: BrGlamorousVectorIcons left.
			moveAttributes add: attribute.
			self sourceCoderViewModel
				addTextAttribute: attribute
				from: each startPosition - 1
				to: each startPosition - 1.
			i < message values size
				ifTrue:
					[ attribute := GtExtractMethodReorderParametersAttribute
						action: [ self swapParameterWithNext: i ]
						icon: BrGlamorousVectorIcons right.
					moveAttributes add: attribute.
					self sourceCoderViewModel
						addTextAttribute: attribute
						from: each stopPosition
						to: each stopPosition ] ]
]

{ #category : #private }
GtExtractMethodFromSnippetController >> boundReceiverValueFor: aString [
	(sourceCoderViewModel compositeVariableBindings hasBindingOf: aString)
		ifTrue: [ (sourceCoderViewModel compositeVariableBindings bindingValueOf: aString) ifNotNil: [ :value | ^ value ] ].
	^ nil
]

{ #category : #executing }
GtExtractMethodFromSnippetController >> createModel [
	| model |
	model := RBClassModelFactory rbNamespace onEnvironment: RBBrowserEnvironment new.
	model name: self refactoringName.
	^ model
]

{ #category : #executing }
GtExtractMethodFromSnippetController >> executeRefactoring [
	| refactoring |

	refactoring := self refactoring.
	self setDefaultOptionsOn: refactoring.
	refactoring primitiveExecute.

	self updateMethod: refactoring snippetSource
]

{ #category : #private }
GtExtractMethodFromSnippetController >> findExtractedSend [
	[ self sourceAst
		withAllNodesOfType: GtPharoMessageNode
		do:
			[ :each | 
			(each selector = self extractedSelector
				and:
					[ ((1 to: methodArguments size)
						allSatisfy:
							[ :i | (each isBinary ifTrue: [ each value ] ifFalse: [ each values at: i ]) source = (methodArguments at: i) ])
						and:
							[ (each parent receiver isKindOf: GtPharoVariableNode) and: [ each parent receiver name value = receiverVariable ] ] ])
				ifTrue: [ ^ each ] ] ] on: SmaCCParserError do: [ :ex | ^ nil ].
	^ nil
]

{ #category : #private }
GtExtractMethodFromSnippetController >> getReceiverVariableFor: cls selector: sel [
	| ast |
	receiverVariable notNil ifTrue: [ ^ receiverVariable ].
	ast := (cls methodFor: sel) ast.
	ast arguments isEmpty
		ifTrue:
			[ ast
				nodesDo:
					[ :each | (each isVariable and: [ Smalltalk globals includesKey: each name asSymbol ]) ifTrue: [ ^ receiverVariable := each name ] ].
			^ receiverVariable := #Object ].
	^ receiverVariable := (ast arguments
		detect: [ :each | (self boundReceiverValueFor: each name) notNil ]
		ifNone: [ ast arguments first ]) name
]

{ #category : #private }
GtExtractMethodFromSnippetController >> getTypeForReceiverFor: aRefactoring from: types [
	^ types reject: [ :e | e isTrait ]
]

{ #category : #private }
GtExtractMethodFromSnippetController >> getTypeForReceiverIn: aModel [
	^ (self boundReceiverValueFor: receiverVariable) ifNotNil: [ :value | Set with: (aModel classFor: value class) ]
]

{ #category : #executing }
GtExtractMethodFromSnippetController >> refactoring [
	| model refactoring |
	model := self createModel.
	refactoring := GtExtractMethodFromSnippetRefactoring extract: self extractionInterval from: originalSource.
	refactoring
		setOption: #selectVariableToMoveTo toUse: [ :ref :cls :sel | self getReceiverVariableFor: cls selector: sel ];
		setOption: #useExistingMethod toUse: [ :ref :sel | false ];
		setOption: #extractAssignment toUse: [ :ref :varName | false ];
		setOption: #variableTypesForReceiver toUse: [ :ref | self getTypeForReceiverIn: ref model ];
		setOption: #variableTypes toUse: [ :ref :types :selected | self getTypeForReceiverFor: ref from: types ].
	^ refactoring
]

{ #category : #executing }
GtExtractMethodFromSnippetController >> setDefaultOptionsOn: aRefactoring [
	super setDefaultOptionsOn: aRefactoring.
	aRefactoring
		setOption: #useExistingMethod toUse: [ :ref :sel | false ];
		setOption: #extractAssignment toUse: [ :ref :varName | false ]
]

{ #category : #executing }
GtExtractMethodFromSnippetController >> setPreviewOptionsOn: aRefactoring [
	super setPreviewOptionsOn: aRefactoring.
	aRefactoring
		setOption: #useExistingMethod toUse: [ :ref :sel | false ];
		setOption: #extractAssignment toUse: [ :ref :varName | false ]
]

{ #category : #private }
GtExtractMethodFromSnippetController >> sourceAst [
	^ GtPharoParser parse: self sourceText characters asString startingAt: GtPharoParser startingStateForMethodSequence
]

{ #category : #private }
GtExtractMethodFromSnippetController >> swapParameterWithNext: anInteger [
	| message oldReceiver |
	anInteger > 0 ifTrue: [ ^ super swapParameterWithNext: anInteger ].
	self removeReorderParametersAttributes.
	self isRenaming ifTrue: [ renameAction uninstall ].
	message := self findExtractedSend.
	message isNil ifTrue: [ ^ self ].
	oldReceiver := receiverVariable.
	receiverVariable := methodArguments first.
	methodArguments at: 1 put: oldReceiver.
	self swap: message parent receiver with: message values first.
	self addReorderParametersAttributes.
	renameIndex notNil ifTrue: [ self installRenamerAt: renameIndex ].
	self addRefactoringPreview
]
