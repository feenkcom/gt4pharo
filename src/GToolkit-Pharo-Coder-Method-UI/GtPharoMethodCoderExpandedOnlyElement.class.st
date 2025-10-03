Class {
	#name : #GtPharoMethodCoderExpandedOnlyElement,
	#superclass : #GtSourceCoderExpandedOnlyElement,
	#instVars : [
		'tagsElement'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-! Views'
}

{ #category : #initialization }
GtPharoMethodCoderExpandedOnlyElement >> initialize [
	super initialize.
	
	tagsElement := self newTagsElement.
	self addChild: tagsElement
]

{ #category : #initialization }
GtPharoMethodCoderExpandedOnlyElement >> newModificationIndicator [
	^ GtPharoMethodCoderModificationIndicator new
		withVerticalLeftIgnoredLayout;
		margin: (BlInsets all: 0)
]

{ #category : #initialization }
GtPharoMethodCoderExpandedOnlyElement >> newTagsElement [
	^ self newTagsElementClass new
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c ignored horizontal alignRight.
			c ignored vertical alignBottom.
			c margin: (BlInsets top: 5 left: 5 bottom: 5 right: 5) ];
		zIndex: 10
]

{ #category : #initialization }
GtPharoMethodCoderExpandedOnlyElement >> newTagsElementClass [
	^ GtPharoMethodCoderTagsElement
]

{ #category : #'api - textual coder view model' }
GtPharoMethodCoderExpandedOnlyElement >> onTextualCoderViewModelChanged [
	super onTextualCoderViewModelChanged.
	
	BlFrameTelemetry
		time: [ tagsElement class name, ' #pharoMethodCoderViewModel:' ]
		during: [ tagsElement pharoMethodCoderViewModel: self textualCoderViewModel ]
]
