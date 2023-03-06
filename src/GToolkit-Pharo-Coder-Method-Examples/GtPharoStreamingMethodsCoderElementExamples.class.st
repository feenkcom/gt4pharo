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

	aScripter := BlScripter new
		element: anElement.

	aScripter assert
		// (GtSourceCoderId indexed: 1);
		exists;
		play.

	^ aScripter
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderElementExamples >> forSuperclassCheckOverridden [
	<gtExample>
	| aScripter |

	aScripter := self forSuperclass.

	aScripter assert
		// (GtSourceCoderId indexed: 1);
		id: GtMethodCoderOverridingOverriddenId;
		value: [ :aButton | aButton visibility ] equals: [ BlVisibility visible ];
		play.

	aScripter assert
		// (GtSourceCoderId indexed: 2);
		id: GtMethodCoderOverridingOverriddenId;
		value: [ :aButton | aButton visibility ] equals: [ BlVisibility gone ];
		play.

	aScripter assert
		// (GtSourceCoderId indexed: 3);
		id: GtMethodCoderOverridingOverriddenId;
		value: [ :aButton | aButton visibility ] equals: [ BlVisibility gone ];
		play.

	aScripter assert
		// (GtSourceCoderId indexed: 4);
		id: GtMethodCoderOverridingOverriddenId;
		value: [ :aButton | aButton visibility ] equals: [ BlVisibility visible ];
		play.

	^ aScripter
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderElementExamples >> forSuperclassClickFirstOverridden [
	<gtExample>
	| aScripter |

	aScripter := self forSuperclassCheckOverridden.

	aScripter click
		// (GtSourceCoderId indexed: 1);
		id: GtMethodCoderOverridingOverriddenId;
		play.

	aScripter assert
		onSpaceRoot;
		id: GtMethodCoderOverriddenAmountId index: 1;
		value: [ :aButton | aButton label asString ] equals: [ '1 method' ];
		play.

	^ aScripter
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderElementExamples >> forSuperclassClickSecondOverridden [
	<gtExample>
	| aScripter |

	aScripter := self forSuperclassCheckOverridden.

	aScripter click
		// (GtSourceCoderId indexed: 4);
		id: GtMethodCoderOverridingOverriddenId;
		play.

	aScripter assert
		onSpaceRoot;
		id: GtMethodCoderOverriddenAmountId;
		value: [ :aButton | aButton label asString ] equals: [ '1 method' ];
		play.

	^ aScripter
]
