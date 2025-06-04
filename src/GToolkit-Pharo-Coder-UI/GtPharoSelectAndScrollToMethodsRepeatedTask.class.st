Class {
	#name : #GtPharoSelectAndScrollToMethodsRepeatedTask,
	#superclass : #BlRepeatedTask,
	#instVars : [
		'contentTabs',
		'maxRepetitions',
		'counter',
		'methods'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #accessing }
GtPharoSelectAndScrollToMethodsRepeatedTask >> contentTabs [
	<return: #BrTabGroup>
	^ contentTabs
]

{ #category : #accessing }
GtPharoSelectAndScrollToMethodsRepeatedTask >> contentTabs: aBrTabGroup [
	self
		assert: [ aBrTabGroup isNotNil ]
		description: [ 'Tab group must be non-nil' ].
	self
		assert: [ contentTabs isNil ]
		description: [ 'Tab group can be initialized only once' ].

	contentTabs := aBrTabGroup
]

{ #category : #initialization }
GtPharoSelectAndScrollToMethodsRepeatedTask >> initialize [
	super initialize.
	
	"Wait delay * maxRepetitions time, 
	which is approximately 500ms * 144 = 72 seconds"
	maxRepetitions := 144.
	counter := 0.
]

{ #category : #accessing }
GtPharoSelectAndScrollToMethodsRepeatedTask >> maxRepetitions [
	^ maxRepetitions
]

{ #category : #accessing }
GtPharoSelectAndScrollToMethodsRepeatedTask >> maxRepetitions: anInteger [
	maxRepetitions := anInteger
]

{ #category : #accessing }
GtPharoSelectAndScrollToMethodsRepeatedTask >> methods [
	<return: #Collection of: #CompiledMethod>
	^ methods
]

{ #category : #accessing }
GtPharoSelectAndScrollToMethodsRepeatedTask >> methods: aCollectionOfCompiledMethods [
	self
		assert: [ aCollectionOfCompiledMethods isNotNil ]
		description: [ 'Methods must be non-nil' ].
	self
		assert: [ methods isNil ]
		description: [ 'Methods can be initialized only once' ].

	methods := aCollectionOfCompiledMethods
]

{ #category : #hooks }
GtPharoSelectAndScrollToMethodsRepeatedTask >> onEnqueuedInElement: anElement [
	element == anElement 
		ifFalse: [ counter := 0 ].

	super onEnqueuedInElement: anElement.
]

{ #category : #'api - running' }
GtPharoSelectAndScrollToMethodsRepeatedTask >> onRun [
	| aTab |
	methods ifNil: [ self stop. ^ self ].
	methods ifEmpty: [ self stop. ^ self ].
	contentTabs ifNil: [ self stop. ^ self ].
	counter > maxRepetitions ifTrue: [ self stop. ^ self ].
	counter := counter + 1.
	
	aTab := contentTabs viewModel tabs
		detect: [ :each | each widget label asString = 'Methods' ]
		ifNone: [ ^ self ].
		
	aTab isSelected ifFalse: [ aTab select ].
	
	contentTabs content 
		allChildrenBreadthFirstDetect: [ :eachElement | 
			eachElement isKindOf: GtPharoStreamingMethodsCoderElement ] 
		ifFound: [ :theElement |
			methods reverseDo: [ :eachMethod |
				theElement streamingCodersViewModel
					expandAndFocusCompiledMethod: eachMethod.
					
				eachMethod == methods first ifTrue: [
					theElement streamingCodersViewModel
						scrollToCompiledMethod: eachMethod ] ].
			self stop ] 
		ifNone: [ "ignore" ]
]

{ #category : #'api - running' }
GtPharoSelectAndScrollToMethodsRepeatedTask >> stop [ 
	super stop.
	counter := 0.
]
