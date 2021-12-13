Class {
	#name : #GtExpandableMethodCoderElement,
	#superclass : #GtExpandableSourceCoderElement,
	#instVars : [
		'tagsElement'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-! Views'
}

{ #category : #private }
GtExpandableMethodCoderElement >> alignTagsElementBottomRight: aTagsElement [
	aTagsElement
		constraintsDo: [ :c |
			c ignored horizontal alignRight.
			c ignored vertical alignBottom ]
]

{ #category : #private }
GtExpandableMethodCoderElement >> alignTagsElementCenterRight: aTagsElement [
	aTagsElement
		constraintsDo: [ :c |
			c ignored horizontal alignRight.
			c ignored vertical alignCenter ]
]

{ #category : #initialization }
GtExpandableMethodCoderElement >> initialize [
	super initialize.
	
	tagsElement := self newTagsElement.
	self addChild: tagsElement
]

{ #category : #'private - instance creation' }
GtExpandableMethodCoderElement >> newTagsElement [
	^ self newTagsElementClass new
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c ignored horizontal alignRight.
			c ignored vertical alignBottom.
			c margin: (BlInsets top: 5 left: 5 bottom: 5 right: 5) ];
		zIndex: 10
]

{ #category : #'private - instance creation' }
GtExpandableMethodCoderElement >> newTagsElementClass [
	^ GtPharoMethodCoderTagsElement
]

{ #category : #private }
GtExpandableMethodCoderElement >> onCollapsed [
	super onCollapsed.
		
	self alignTagsElementCenterRight: tagsElement
]

{ #category : #private }
GtExpandableMethodCoderElement >> onExpanded [
	super onExpanded.
		
	self alignTagsElementBottomRight: tagsElement
]

{ #category : #'api - textual coder view model' }
GtExpandableMethodCoderElement >> onTextualCoderViewModelChanged [
	super onTextualCoderViewModelChanged.
	
	BlFrameTelemetry
		time: [ tagsElement class name, ' #pharoMethodCoderViewModel:' ]
		during: [ tagsElement pharoMethodCoderViewModel: textualCoderViewModel ]
]
