Class {
	#name : #GtPharoStreamingMethodsCoderElementExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Method-Examples-Coder'
}

{ #category : #examples }
GtPharoStreamingMethodsCoderElementExamples >> forSuperclass [
	<gtExample>
	| aViewModel anElement aScripter |
	aViewModel := GtPharoStreamingMethodsCoderViewModelExamples new forSuperclass.

	anElement := GtPharoStreamingMethodsCoderElement new
			streamingCodersViewModel: aViewModel.

	aScripter := BlScripter new element: anElement.
	
	"For some reason we need to wait to propagate search filter changes.
	Is there any background computation that the UI is not aware of?"
	aScripter wait 
		forEnqueuedSpaceTaskTimeout: 1 second; 
		play.

	aScripter
		assertStep: [ :s | 
			s
				// (GtSourceCoderId indexed: 1);
				exists ].

	^ aScripter
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderElementExamples >> forSuperclassCheckOverridden [
	<gtExample>
	| aScripter |
	aScripter := self forSuperclass.

	aScripter
		assertStep: [ :s | 
			s
				// (GtSourceCoderId indexed: 1);
				id: GtMethodCoderOverridingOverriddenId;
				value: [ :aButton | aButton visibility ] 
					equals: [ BlVisibility visible ] ].

	aScripter
		assertStep: [ :s | 
			s
				// (GtSourceCoderId indexed: 2);
				id: GtMethodCoderOverridingOverriddenId;
				value: [ :aButton | aButton visibility ] 
					equals: [ BlVisibility gone ] ].

	aScripter
		assertStep: [ :s | 
			s
				// (GtSourceCoderId indexed: 3);
				id: GtMethodCoderOverridingOverriddenId;
				value: [ :aButton | aButton visibility ] 
					equals: [ BlVisibility gone ] ].

	aScripter
		assertStep: [ :s | 
			s
				// (GtSourceCoderId indexed: 4);
				id: GtMethodCoderOverridingOverriddenId;
				value: [ :aButton | aButton visibility ] 
					equals: [ BlVisibility visible ] ].

	^ aScripter
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderElementExamples >> forSuperclassClickFirstOverridden [
	<gtExample>
	| aScripter |
	aScripter := self forSuperclassCheckOverridden.

	aScripter
		clickStep: [ :s | 
			s
				// (GtSourceCoderId indexed: 1);
				id: GtMethodCoderOverridingOverriddenId ].

	aScripter
		assertStep: [ :s | 
			s
				onSpaceRoot;
				id: GtMethodCoderOverriddenAmountId index: 1;
				value: [ :aButton | aButton label asString ] equals: [ '1 method' ] ].

	^ aScripter
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderElementExamples >> forSuperclassClickSecondOverridden [
	<gtExample>
	| aScripter |
	aScripter := self forSuperclassCheckOverridden.

	aScripter
		clickStep: [ :s | 
			s
				// (GtSourceCoderId indexed: 4);
				id: GtMethodCoderOverridingOverriddenId ].

	aScripter
		assertStep: [ :s | 
			s
				onSpaceRoot;
				id: GtMethodCoderOverriddenAmountId;
				value: [ :aButton | aButton label asString ] equals: [ '1 method' ] ].

	^ aScripter
]
