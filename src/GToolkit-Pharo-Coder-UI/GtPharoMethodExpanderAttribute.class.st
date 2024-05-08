Class {
	#name : #GtPharoMethodExpanderAttribute,
	#superclass : #BrGlamorousTriangleExpanderTextAttribute,
	#instVars : [
		'classOrMetaClass',
		'selector',
		'argumentBindingsBuilder'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Attributes'
}

{ #category : #'instance creation' }
GtPharoMethodExpanderAttribute class >> forClass: aClass andSelector: aSymbol [
	^ self new
		forClass: aClass andSelector: aSymbol;
		yourself
]

{ #category : #accessing }
GtPharoMethodExpanderAttribute >> argumentBindingsBuilder [
	<return: #GtPharoReceiverAndArgumentBindingsBuilder>
	^ argumentBindingsBuilder
]

{ #category : #accessing }
GtPharoMethodExpanderAttribute >> argumentBindingsBuilder: anObject [
	argumentBindingsBuilder := anObject
]

{ #category : #private }
GtPharoMethodExpanderAttribute >> buildMethodCoder [
	| editorElement coder method viewModel |
	(method := self compiledMethod) ifNil: [ ^ BlElement new ].
	coder := GtPharoMethodCoder forMethod: method.
	coder subscribeToSystem.
	viewModel := coder asCoderViewModel.
	self
		configureViewModel: viewModel
		andCoder: coder.

	editorElement := viewModel asElement.

	self id isIndexed
		ifTrue: [ editorElement id: (GtPharoEmbeddedMethodId indexed: self id index) ]
		ifFalse: [ editorElement id: GtPharoEmbeddedMethodId ].

	editorElement
		margin: (BlInsets
				top: 3
				right: 10
				bottom: 10
				left: 10).
	^ editorElement
]

{ #category : #accessing }
GtPharoMethodExpanderAttribute >> classOrMetaClass [
	^ classOrMetaClass
]

{ #category : #accessing }
GtPharoMethodExpanderAttribute >> compiledMethod [
	^ classOrMetaClass lookupSelector: selector
]

{ #category : #private }
GtPharoMethodExpanderAttribute >> configureViewModel: viewModel andCoder: coder [
	argumentBindingsBuilder ifNil: [ ^ self ].
	argumentBindingsBuilder compiledMethod: self compiledMethod.
	argumentBindingsBuilder build.

	argumentBindingsBuilder explicitProviderClass
		ifNotNil: [ :aClass | coder explicitProviderClass: aClass ].
	argumentBindingsBuilder localBindings
		ifNotNil: [ :aLocalBindings | viewModel addLocalBindings: aLocalBindings ].
	argumentBindingsBuilder receiverObject
		ifNotNil: [ :aSelfObject | viewModel selfObject: aSelfObject ]
]

{ #category : #'initialize-release' }
GtPharoMethodExpanderAttribute >> forClass: aClass andSelector: aSymbol [
	classOrMetaClass := aClass.
	selector := aSymbol
]

{ #category : #'initialize-release' }
GtPharoMethodExpanderAttribute >> initialize [
	super initialize.
	self
		attributesCreatingBlock: [ BrTextAdornmentDynamicAttribute new
				beAppend;
				stencil: [ self buildMethodCoder ] ]
]

{ #category : #printing }
GtPharoMethodExpanderAttribute >> printOn: aStream [
	aStream
		nextPutAll: 'method-expander: ';
		print: self id
]

{ #category : #accessing }
GtPharoMethodExpanderAttribute >> selector [
	^ selector
]
