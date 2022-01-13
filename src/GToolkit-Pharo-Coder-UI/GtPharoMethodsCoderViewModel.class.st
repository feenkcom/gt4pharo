Class {
	#name : #GtPharoMethodsCoderViewModel,
	#superclass : #GtMultipleCodersViewModel,
	#instVars : [
		'focusedCoderUIModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! View Models'
}

{ #category : #'api - interations' }
GtPharoMethodsCoderViewModel >> addNewCoder [
	| aNewCoder |
	
	aNewCoder := self coder addNewCoder.
	self
		expandCoder: aNewCoder;
		focusCoder: aNewCoder.
	^ aNewCoder
]

{ #category : #updating }
GtPharoMethodsCoderViewModel >> coderUIModelFor: aCoder [
	^ aCoder asCoderViewModel
		expanded: false;
		selfObject: self coder object
]

{ #category : #accessing }
GtPharoMethodsCoderViewModel >> elementClass [
	^ GtPharoMethodsCoderElement
]

{ #category : #'api - interations' }
GtPharoMethodsCoderViewModel >> expandCoder: aMethodCoder [
	coderUIModels
		detect: [ :eachCoderUIModel | eachCoderUIModel coder = aMethodCoder ]
		ifFound: [ :targetCoderUIModel | targetCoderUIModel expanded: true ]
]

{ #category : #'api - interations' }
GtPharoMethodsCoderViewModel >> focusCoder: aMethodCoder [
	coderUIModels
		detect: [ :eachCoderUIModel | eachCoderUIModel coder = aMethodCoder ]
		ifFound: [ :targetCoderUIModel | self focusCoderUIModel: targetCoderUIModel ]
]

{ #category : #'api - focus' }
GtPharoMethodsCoderViewModel >> focusCoderUIModel: aCoderUIModel [
	(focusedCoderUIModel notNil
		and: [ focusedCoderUIModel ~= aCoderUIModel ])
		ifTrue: [ focusedCoderUIModel focused: false.
			focusedCoderUIModel := nil ].
	focusedCoderUIModel := aCoderUIModel.
	focusedCoderUIModel focused: true
]

{ #category : #accessing }
GtPharoMethodsCoderViewModel >> focusedCoderUIModel [
	<return: #GtSingleCoderViewModel>

	^ focusedCoderUIModel
]

{ #category : #'api - focus' }
GtPharoMethodsCoderViewModel >> unfocusCoderUIModel: aCoderUIModel [
	focusedCoderUIModel = aCoderUIModel
		ifTrue: [ focusedCoderUIModel := nil ].

	aCoderUIModel hasFocus: false
]
