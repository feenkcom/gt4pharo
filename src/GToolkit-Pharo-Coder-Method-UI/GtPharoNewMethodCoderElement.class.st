Class {
	#name : #GtPharoNewMethodCoderElement,
	#superclass : #BrFrame,
	#traits : 'TGtWithPharoMethodCoderViewModel',
	#classTraits : 'TGtWithPharoMethodCoderViewModel classTrait',
	#instVars : [
		'sourceCoderElement',
		'tagsElement',
		'behavior',
		'methodCoderViewModelValueHolder',
		'onMethodCoderSaved'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-! Views'
}

{ #category : #initialization }
GtPharoNewMethodCoderElement class >> preferredExtent [
	^ 400 @ 150
]

{ #category : #'api - initialization' }
GtPharoNewMethodCoderElement >> behavior: aBehavior [
	"Behavior is a class (or Trait) for which a new method will be created."

	behavior := aBehavior
]

{ #category : #'private - updating' }
GtPharoNewMethodCoderElement >> ensureMethodCoderViewModel [
	| aNewMethodCoderViewModel aNewMethodCoder newMethodText |
	aNewMethodCoderViewModel := methodCoderViewModelValueHolder
				ifNotNil: #contents.
	aNewMethodCoderViewModel
		ifNotNil: 
			[self pharoMethodCoderViewModel: aNewMethodCoderViewModel.
			^self].
	newMethodText := ('' asRopedText)
				glamorousCodeFontAndSize;
				attribute: (BrGhostTextAttribute
							for: ('newMethod' asRopedText glamorousCodeFontAndSize
									foreground: Color lightGray))
								beNotOverwritableByStyler.
	aNewMethodCoder := (GtPharoMethodCoder
				forNewMethod: (behavior ifNil: [Object]))
				currentSourceText: newMethodText;
				protocol: AbstractProtocol unclassified;
				yourself.
	aNewMethodCoderViewModel := (aNewMethodCoder asCoderViewModel)
				withoutHeader;
				expanded: true;
				focused: true;
				moveCursorAtEnd.
	self pharoMethodCoderViewModel: aNewMethodCoderViewModel.
	methodCoderViewModelValueHolder
		ifNotNil: [:aValueHolder | aValueHolder contents: aNewMethodCoderViewModel]
]

{ #category : #'private - event handling' }
GtPharoNewMethodCoderElement >> handleMethodCoderSaved: anAnnouncement [
	onMethodCoderSaved
		ifNotNil: [ :anAction | 
			anAction cull: anAnnouncement 
			cull: self pharoMethodCoderViewModel ]
]

{ #category : #initialization }
GtPharoNewMethodCoderElement >> initialize [
	super initialize.
	self initializeSourceCoderElement.
	self initializeMethodCoderTagsElement.
	
	sourceCoderElement actions addChild: tagsElement.
	self addChild: sourceCoderElement.

	self
		hExact: self class preferredExtent x;
		vFitContentLimited;
		background: Color white;
		addAptitude: BrGlamorousFocusableShadowAptitude new
]

{ #category : #initialization }
GtPharoNewMethodCoderElement >> initializeMethodCoderTagsElement [
	tagsElement := GtPharoMethodCoderTagsElement new
			constraintsDo: [ :c | 
				c ignoreByLayout.
				c ignored horizontal alignRight.
				c ignored vertical alignBottom.
				c margin: (BlInsets bottom: -2) ]
]

{ #category : #initialization }
GtPharoNewMethodCoderElement >> initializeSourceCoderElement [
	sourceCoderElement := GtSourceCoderExpandedContentElement new
		hMatchParent;
		vFitContentLimited;
		background: Color white;
		addAptitude: BrGlamorousFocusableShadowAptitude new
]

{ #category : #'api - initialization' }
GtPharoNewMethodCoderElement >> methodCoderViewModelValueHolder: aValueHolder [
	"Value holder is an object that understands #contents and #contents:.
It is used to store (and reuse) the method coder view model 
while the element may be created and destroyed several times."

	methodCoderViewModelValueHolder := aValueHolder.
]

{ #category : #'hooks - children' }
GtPharoNewMethodCoderElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.

	self hasPharoMethodCoderViewModel ifTrue: [ ^ self ].
	behavior ifNil: [ ^ self ].
	self ensureMethodCoderViewModel
]

{ #category : #'api - initialization' }
GtPharoNewMethodCoderElement >> onMethodCoderSaved: anAction [
	"Action is an object that undrestand #cull:cull:, e.g., 
	[ :anAnnouncement :aMethodCoderViewModel | ]"

	onMethodCoderSaved := anAction
]

{ #category : #'api - pharo method coder view model' }
GtPharoNewMethodCoderElement >> onPostPharoMethodCoderViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoMethodCoderViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."

	sourceCoderElement coderViewModel: self pharoMethodCoderViewModel.
	tagsElement pharoMethodCoderViewModel: self pharoMethodCoderViewModel
]

{ #category : #'api - pharo method coder view model' }
GtPharoNewMethodCoderElement >> subscribeToPharoMethodCoderViewModel [
	"Is sent after a new pharoMethodCoderViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoMethodCoderViewModel if the receiver subscribes to them"

	self pharoMethodCoderViewModel weak
		when: GtMethodCoderSaved
		send: #handleMethodCoderSaved:
		to: self
]

{ #category : #'api - pharo method coder view model' }
GtPharoNewMethodCoderElement >> unsubscribeFromPharoMethodCoderViewModel [
	"Is sent before a new pharoMethodCoderViewModel is assigned to the receiver.
	Objects that subscribe to pharoMethodCoderViewModel are required to implement this method."

	self pharoMethodCoderViewModel unsubscribe: self
]
