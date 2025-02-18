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
	self prepareConfigurationBuilder.
	coder := self createCoderForMethod: method.
	coder subscribeToSystem.
	viewModel := coder asCoderViewModel.
	self configureViewModel: viewModel andCoder: coder.

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
	argumentBindingsBuilder compiledMethod ifNil: [ ^ self ].

	argumentBindingsBuilder explicitProviderClass
		ifNotNil: [ :aClass | coder explicitProviderClass: aClass ].
	argumentBindingsBuilder localBindings
		ifNotNil: [ :aLocalBindings | viewModel addLocalBindings: aLocalBindings ].
	argumentBindingsBuilder receiverObjectHolder
		ifNotNil: [ :aSelfObjectHolder | viewModel selfObjectHolder: aSelfObjectHolder ].
	argumentBindingsBuilder parentExample
		ifNotNil: [ :anExample | viewModel parentExample: anExample ].
	argumentBindingsBuilder parentTestCase
		ifNotNil: [ :aTestCase | viewModel parentTestCase: aTestCase ].
	argumentBindingsBuilder parentCoderViewModel
		ifNotNil: [ :aCoderViewModel | viewModel parentCoderViewModel: aCoderViewModel ].
]

{ #category : #private }
GtPharoMethodExpanderAttribute >> createCoderForMethod: method [
	argumentBindingsBuilder ifNil: [ 
		^ GtPharoMethodCoder forMethod: method ].
	
	^ argumentBindingsBuilder receiverSubclassBehavior
		ifNotNil: [ :aSubclassBehavior | 
			GtPharoMethodCoder forMethod: method in: aSubclassBehavior ]
		ifNil: [
			GtPharoMethodCoder forMethod: method ].
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

{ #category : #private }
GtPharoMethodExpanderAttribute >> prepareConfigurationBuilder [
	argumentBindingsBuilder ifNil: [ ^ self ].
	argumentBindingsBuilder compiledMethod: self compiledMethod.
	argumentBindingsBuilder build.
]

{ #category : #private }
GtPharoMethodExpanderAttribute >> prepareConfigurationBuilderForMethod: aMethod [
	self assert: [ aMethod isNotNil ] description: [ 'Method must be non-nil' ].
	
	argumentBindingsBuilder ifNil: [ ^ self ].
	argumentBindingsBuilder compiledMethod: aMethod.
	argumentBindingsBuilder build
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
