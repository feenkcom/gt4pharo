Class {
	#name : #GtPharoStreamingMethodsCoderViewModel,
	#superclass : #GtFilteredCodersViewModel,
	#instVars : [
		'shouldExpandByDefault',
		'shouldHaveHeaderByDefault',
		'selfObject'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-! View Models'
}

{ #category : #'api - coders' }
GtPharoStreamingMethodsCoderViewModel >> expandAndFocusCompiledMethod: aCompiledMethod [
	self enqueueCommand: (GtPharoExpandMethodCoderViewModelCommand new
		behaviorName: aCompiledMethod methodClass name;
		selector: aCompiledMethod selector)
]

{ #category : #initialization }
GtPharoStreamingMethodsCoderViewModel >> initialize [
	super initialize.
	
	selfObject := nil.
	shouldExpandByDefault := false.
	shouldHaveHeaderByDefault := false
]

{ #category : #'private - updating' }
GtPharoStreamingMethodsCoderViewModel >> initializeSelfObjectForCoderViewModel: aCoderViewModel [
	"Set selfObject only on the instance side methods.
	See https://github.com/feenkcom/gtoolkit/issues/4127"
	
	^ aCoderViewModel isMeta
		ifTrue: [ selfObject
				ifNotNil: [ :theObject | aCoderViewModel selfObject: theObject class ]
				ifNil: [ aCoderViewModel selfObject: streamingCodersModel behavior ] ]
		ifFalse: [ aCoderViewModel selfObject: selfObject ]
]

{ #category : #'instance creation' }
GtPharoStreamingMethodsCoderViewModel >> newCoderViewModelFor: aCoderModel [
	| header aCoderViewModel |
	"Show header for methods from other classes"
	header := shouldHaveHeaderByDefault
			or: [ aCoderModel methodBehavior behavior ~= streamingCodersModel behavior
					and: [ aCoderModel methodBehavior behavior ~= streamingCodersModel behavior class ] ].
	
	aCoderViewModel := aCoderModel asCoderViewModel
		expanded: shouldExpandByDefault;
		shouldHaveHeader: header;
		highlighter: highlighter.
		
	self initializeSelfObjectForCoderViewModel: aCoderViewModel.
	
	^ aCoderViewModel
]

{ #category : #'private - event handling' }
GtPharoStreamingMethodsCoderViewModel >> onCodersStreamChanged: anAnnouncement [
	| aCoderViewModelA aCoderViewModelB |
	
	super onCodersStreamChanged: anAnnouncement.
	
	(anAnnouncement isDueTo: GtStreamingCodersSwappedReason)
		ifFalse: [ ^ self ].

	aCoderViewModelA := self privateFetchCoderViewModelFor: anAnnouncement dueTo coderA.
	aCoderViewModelB := self privateFetchCoderViewModelFor: anAnnouncement dueTo coderB.
	
	aCoderViewModelA focused
		ifTrue: [
			self scrollToCompiledMethod: aCoderViewModelA compiledMethod ]
				ifFalse: [ aCoderViewModelB focused
				ifTrue: [ self scrollToCompiledMethod: aCoderViewModelB compiledMethod ] ]
]

{ #category : #'api - coders' }
GtPharoStreamingMethodsCoderViewModel >> scrollToCompiledMethod: aCompiledMethod [
	self scrollToTarget: (GtPharoMethodCoderViewModelScrollTarget new
		behaviorName: aCompiledMethod methodClass name;
		selector: aCompiledMethod selector)
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderViewModel >> selfObject [

	^ selfObject
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderViewModel >> selfObject: anObject [
	selfObject := anObject.
	coderViewModels valuesDo: [ :eachCoderViewModel | 
		self initializeSelfObjectForCoderViewModel: eachCoderViewModel ]
]

{ #category : #'api - accessing' }
GtPharoStreamingMethodsCoderViewModel >> shouldExpandByDefault [

	^ shouldExpandByDefault
]

{ #category : #'api - accessing' }
GtPharoStreamingMethodsCoderViewModel >> shouldExpandByDefault: anObject [

	shouldExpandByDefault := anObject
]

{ #category : #'api - accessing' }
GtPharoStreamingMethodsCoderViewModel >> shouldHaveHeaderByDefault [

	^ shouldHaveHeaderByDefault
]

{ #category : #'api - accessing' }
GtPharoStreamingMethodsCoderViewModel >> shouldHaveHeaderByDefault: anObject [

	shouldHaveHeaderByDefault := anObject
]
