Class {
	#name : #GtPharoMethodsCoderView,
	#superclass : #Object,
	#instVars : [
		'filter',
		'shouldHaveTestsRunner',
		'shouldHaveExamplesRunner'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Utilities'
}

{ #category : #accessing }
GtPharoMethodsCoderView >> filter [

	^ filter
]

{ #category : #accessing }
GtPharoMethodsCoderView >> filter: anObject [

	filter := anObject
]

{ #category : #initialization }
GtPharoMethodsCoderView >> initialize [
	super initialize.
	
	shouldHaveTestsRunner := true.
	shouldHaveExamplesRunner := true
]

{ #category : #accessing }
GtPharoMethodsCoderView >> shouldHaveExamplesRunner [

	^ shouldHaveExamplesRunner
]

{ #category : #accessing }
GtPharoMethodsCoderView >> shouldHaveExamplesRunner: anObject [

	shouldHaveExamplesRunner := anObject
]

{ #category : #accessing }
GtPharoMethodsCoderView >> shouldHaveTestsRunner [

	^ shouldHaveTestsRunner
]

{ #category : #accessing }
GtPharoMethodsCoderView >> shouldHaveTestsRunner: anObject [

	shouldHaveTestsRunner := anObject
]
