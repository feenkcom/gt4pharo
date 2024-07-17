"
I wait for `Methods` tab provided by a given {{gtMethod: GtPharoSelectAndScrollToMethodRepeatedTask >> #contentTabs}}. 
Then I wait for a {{gtClass:GtPharoStreamingMethodsCoderElement}} element. 
Once that element is available, I expand, focus and scroll to a given {{gtMethod: GtPharoSelectAndScrollToMethodRepeatedTask>>#method | label=#selector}}. 
I am used in {{gtMethod:GtPharoBehaviorCoderElement>>#actOnSelectMethod:}}. 
"
Class {
	#name : #GtPharoSelectAndScrollToMethodRepeatedTask,
	#superclass : #BlRepeatedTask,
	#instVars : [
		'method',
		'contentTabs',
		'maxRepetitions',
		'counter'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #accessing }
GtPharoSelectAndScrollToMethodRepeatedTask >> contentTabs [
	<return: #BrTabGroup>
	^ contentTabs
]

{ #category : #accessing }
GtPharoSelectAndScrollToMethodRepeatedTask >> contentTabs: aBrTabGroup [
	self
		assert: [ aBrTabGroup isNotNil ]
		description: [ 'Tab group must be non-nil' ].
	self
		assert: [ contentTabs isNil ]
		description: [ 'Tab group can be initialized only once' ].

	contentTabs := aBrTabGroup
]

{ #category : #initialization }
GtPharoSelectAndScrollToMethodRepeatedTask >> initialize [
	super initialize.
	
	"Wait delay * maxRepetitions time, 
	which is approximately 500ms * 144 = 72 seconds"
	maxRepetitions := 144.
	counter := 0.
]

{ #category : #accessing }
GtPharoSelectAndScrollToMethodRepeatedTask >> maxRepetitions [
	^ maxRepetitions
]

{ #category : #accessing }
GtPharoSelectAndScrollToMethodRepeatedTask >> maxRepetitions: anInteger [
	maxRepetitions := anInteger
]

{ #category : #accessing }
GtPharoSelectAndScrollToMethodRepeatedTask >> method [
	<return: #CompiledMethod>
	^ method
]

{ #category : #accessing }
GtPharoSelectAndScrollToMethodRepeatedTask >> method: aCompiledMethod [
	self
		assert: [ aCompiledMethod isNotNil ]
		description: [ 'Method must be non-nil' ].
	self
		assert: [ method isNil ]
		description: [ 'Method can be initialized only once' ].

	method := aCompiledMethod
]

{ #category : #hooks }
GtPharoSelectAndScrollToMethodRepeatedTask >> onEnqueuedInElement: anElement [
	element == anElement 
		ifFalse: [ counter := 0 ].

	super onEnqueuedInElement: anElement.
]

{ #category : #'api - running' }
GtPharoSelectAndScrollToMethodRepeatedTask >> onRun [
	| aTab |
	method ifNil: [ self stop. ^ self ].
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
			theElement streamingCodersViewModel
				expandAndFocusCompiledMethod: method;
				scrollToCompiledMethod: method.
			self stop ] 
		ifNone: [ "ignore" ]
]

{ #category : #'api - running' }
GtPharoSelectAndScrollToMethodRepeatedTask >> stop [ 
	super stop.
	counter := 0.
]
