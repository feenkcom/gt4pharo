Class {
	#name : #GtMethodInlineMessageFromComponentRefactoringController,
	#superclass : #GtPharoSourceCoderRefactoringController,
	#instVars : [
		'implementor',
		'node',
		'receiverTypeAttribute'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #accessing }
GtMethodInlineMessageFromComponentRefactoringController >> addReceiverTypeAttribute [
	self removeReceiverTypeAttribute.
	receiverTypeAttribute := self sourceCoderViewModel
			addTextAttribute: (GtClassPickerAttribute new
					refactoringController: self;
					classes: self potentialImplementors;
					selected: self implementor;
					yourself)
			from: self receiverAttributePosition
			to: self receiverAttributePosition
]

{ #category : #accessing }
GtMethodInlineMessageFromComponentRefactoringController >> cleanUp [
	super cleanUp.
	self removeReceiverTypeAttribute
]

{ #category : #accessing }
GtMethodInlineMessageFromComponentRefactoringController >> implementor [
	^ implementor ifNil: [ implementor := self potentialImplementors anyOne ]
]

{ #category : #initialization }
GtMethodInlineMessageFromComponentRefactoringController >> implementor: aClass [
	implementor := aClass
]

{ #category : #accessing }
GtMethodInlineMessageFromComponentRefactoringController >> installAttributes [
	self addReceiverTypeAttribute.
	self addRefactoringPreview
]

{ #category : #accessing }
GtMethodInlineMessageFromComponentRefactoringController >> node [
	^ node
]

{ #category : #accessing }
GtMethodInlineMessageFromComponentRefactoringController >> node: aMessageSend [
	node := aMessageSend
]

{ #category : #accessing }
GtMethodInlineMessageFromComponentRefactoringController >> performMethodRefactoring: aRefactoring [
	[ aRefactoring primitiveExecute.
	(aRefactoring model changes changes
		allSatisfy: [ :each | 
			(each isKindOf: RBAddMethodChange)
				and: [ each selector = sourceCoderViewModel coderModel currentSelector
						and: [ sourceCoderViewModel behavior = each changeClass ] ] ])
		ifTrue: [ (self changedSourceForCurrentMethod: aRefactoring model changes)
				ifNotNil: [ :source | ^ self setText: source ] ] ]
		on: RBRefactoringError
		do: [ :ex | ^ self inform: ex messageText ].
	self preventSave.
	sourceCoderViewModel selectNone.
	self addRefactoringPreview
]

{ #category : #accessing }
GtMethodInlineMessageFromComponentRefactoringController >> potentialImplementors [
	^ ((GtPharoIndex current implementersOf: node selector)
		collect: [ :each | each methodClass ])
		asSortedCollection: [ :a :b | a name < b name ]
]

{ #category : #accessing }
GtMethodInlineMessageFromComponentRefactoringController >> previewPosition [
	^ node message selectorParts last stopPosition
]

{ #category : #accessing }
GtMethodInlineMessageFromComponentRefactoringController >> receiverAttributePosition [
	^ node receiver stopPosition
]

{ #category : #accessing }
GtMethodInlineMessageFromComponentRefactoringController >> refactoring [
	| refactoring model |
	model := self createRefactoringModel.

	refactoring := self refactoringClass
			model: model
			inline: node sourceInterval
			inMethod: sourceCoderViewModel coderModel currentSelector
			forClass: (model classFor: sourceCoderViewModel behavior).

	refactoring setOption: #inlineExpression toUse: [ :ref :string | true ].
	refactoring
		setOption: #implementorToInline
		toUse: [ :ref :classes | classes detect: [ :each | each realClass = self implementor ] ifNone: [ nil ] ].
	^ refactoring
]

{ #category : #accessing }
GtMethodInlineMessageFromComponentRefactoringController >> refactoringClass [
	^ GtInlineMethodFromComponentRefactoring
]

{ #category : #accessing }
GtMethodInlineMessageFromComponentRefactoringController >> refactoringName [
	^ 'Inline message send'
]

{ #category : #accessing }
GtMethodInlineMessageFromComponentRefactoringController >> removeReceiverTypeAttribute [
	receiverTypeAttribute ifNil: [ ^ self ].
	self sourceCoderViewModel removeCoderTextAttributes: receiverTypeAttribute.
	receiverTypeAttribute := nil
]

{ #category : #accessing }
GtMethodInlineMessageFromComponentRefactoringController >> safelyExecute [
	self preventSave.
	self installAttributes
]

{ #category : #executing }
GtMethodInlineMessageFromComponentRefactoringController >> selectClass: aClass [
	self implementor: aClass.
	self installAttributes
]
