Class {
	#name : #GtPharoStreamingMethodsCoderViewModel,
	#superclass : #GtStreamingCodersViewModel,
	#instVars : [
		'shouldExpandByDefault',
		'shouldHaveHeaderByDefault',
		'highlighter'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! View Models'
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
	
	shouldExpandByDefault := false.
	shouldHaveHeaderByDefault := false
]

{ #category : #'instance creation' }
GtPharoStreamingMethodsCoderViewModel >> newCoderViewModelFor: aCoderModel [
	^ aCoderModel asCoderViewModel
		expanded: shouldExpandByDefault;
		shouldHaveHeader: shouldHaveHeaderByDefault;
		highlighter: highlighter
]

{ #category : #'private - event handling' }
GtPharoStreamingMethodsCoderViewModel >> onCodersStreamChanged: anAnnouncement [
	super onCodersStreamChanged: anAnnouncement.

	((anAnnouncement isDueTo: GtFilteredCodersFilterReason)
		or: [ anAnnouncement isDueTo: GtFilteredCodersAdditionalFiltersReason ])
			ifFalse: [ ^ self ].

	self updateFiltersHighlighter
]

{ #category : #'api - streaming coders model' }
GtPharoStreamingMethodsCoderViewModel >> onStreamingCodersModelChanged [
	"Is sent when a new streamingCodersModel is assigned to the receiver.
	Note: #onStreamingCodersModelChanged is sent before #subscribeToStreamingCodersModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostStreamingCodersModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	super onStreamingCodersModelChanged.
	self updateFiltersHighlighter
]

{ #category : #'api - coders' }
GtPharoStreamingMethodsCoderViewModel >> scrollToCompiledMethod: aCompiledMethod [
	self scrollToTarget: (GtPharoMethodCoderViewModelScrollTarget new
		behaviorName: aCompiledMethod methodClass name;
		selector: aCompiledMethod selector)
]

{ #category : #'api - accessing' }
GtPharoStreamingMethodsCoderViewModel >> shouldExpandByDefault [

	^ shouldExpandByDefault
]

{ #category : #'api - accessing' }
GtPharoStreamingMethodsCoderViewModel >> shouldExpandByDefault: anObject [

	shouldExpandByDefault := anObject
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderViewModel >> shouldHaveHeaderByDefault [

	^ shouldHaveHeaderByDefault
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderViewModel >> shouldHaveHeaderByDefault: anObject [

	shouldHaveHeaderByDefault := anObject
]

{ #category : #'private - update' }
GtPharoStreamingMethodsCoderViewModel >> updateFiltersHighlighter [	
	highlighter := streamingCodersModel compositeFilter highlighter.
	coderViewModels valuesDo: [ :eachCoderViewModel |
		eachCoderViewModel highlighter: highlighter ]
]
