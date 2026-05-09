Class {
	#name : #GtPharoClassExpanderStylerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : #development }
GtPharoClassExpanderStylerExamples >> assert: aStep behaviorExpandersCount: anInteger [
	anInteger isZero
		ifTrue: [ aStep assert
				label: 'Assert zero behavior expanders';
				notExists;
				// BrInlineExpanderElement;
				play ]
		ifFalse: [ self halt.
			aStep assert
				label: ('Assert expanded behaviors count is {1}' format: {anInteger});
				value: [ :anElement | anElement isExpanded ] equals: anInteger;
				// BrInlineExpanderElement;
				play ]
]

{ #category : #development }
GtPharoClassExpanderStylerExamples >> assert: aStep expandedBehaviorAt: anInteger [
	aStep assert
		label: ('Assert expanded behavior expander at {1}' format: {anInteger});
		value: [ :anElement | anElement isExpanded ] equals: true;
		// (GtPharoBehaviorExpanderId indexed: anInteger);
		play.

	aStep assert
		label: ('Assert existing expanded behavior at {1}' format: {anInteger});
		exists;
		// (GtPharoExpandedBehaviorId indexed: anInteger);
		play
]

{ #category : #development }
GtPharoClassExpanderStylerExamples >> astAndClassCache [
	<gtExample>
	| coder coderViewModel text styler someAttributes astCache behaviorCache astCacheValues behaviorCacheValues expanderAttributes expanderElement |
	self
		expanderStylerVersion: 6
		during: [ coder := GtPharoMethodCoder
					forClass: Object
					source: 'foo |oc| oc := OrderedCollection new'.
			coderViewModel := coder asCoderViewModel.
			coderViewModel stylers.

			text := coder currentSourceText copy.
			styler := GtPharoClassExpanderStyler new
					coderViewModel: coderViewModel;
					style: text ast: coder astSync ].

	someAttributes := self classExpanderWithMarkerHiddingAndCachingElementAttributesIn: text.
	expanderAttributes := someAttributes
			select: [ :each | each expandedClass = OrderedCollection ].
	self assert: expanderAttributes size equals: 1.
	
	astCache := styler privateAttributesCache.
	behaviorCache := styler privateBehaviorCache.

	astCacheValues := astCache associations.
	behaviorCacheValues := behaviorCache associations.
	self assert: astCacheValues size equals: 1.
	self assert: behaviorCacheValues size equals: 1.
	self assert: astCacheValues first value size equals: 2.
	self assert: behaviorCacheValues first key equals: OrderedCollection.

	^ GtPharoClassExpanderStylerExampleResult new
		coderViewModel: coderViewModel;
		text: text;
		styler: styler;
		attributes: someAttributes
]

{ #category : #development }
GtPharoClassExpanderStylerExamples >> astAndClassCacheScripter [
	<gtExample>
	| result scripter query |
	result := self astAndClassCache.
	scripter := BlScripter new model: result.

	self
		expanderStylerVersion: 6
		during: [ scripter
				element: (GtExpandableSourceCoderElement new
						matchParent;
						textualCoderViewModel: result coderViewModel) ].

	self
		useIncrementalParsingDuring: [ scripter editor
				requestFocus;
				assertHasFocus;
				// GtSourceCoderEditorInnerId;
				play.

			self click: scripter behaviorExpanderAt: 1.
			self assert: scripter expandedBehaviorAt: 1.

			query := scripter element query
					// (GtPharoExpandedBehaviorId indexed: 1).
			self assert: query all size equals: 1.
			scripter userData at: #originalExpandedBehaviorElement put: query anyOne ].

	^ scripter
]

{ #category : #development }
GtPharoClassExpanderStylerExamples >> astAndClassCacheScripter_typeBefore [
	<gtExample>
	| result scripter |
	scripter := self astAndClassCacheScripter.
	result := scripter model.

	self
		useIncrementalParsingDuring: [ 
			scripter editor
				moveToHome;
				in: [ :aStep | 7 timesRepeat: [ aStep moveRight ] ];
				typeText: ' o';
				// GtSourceCoderEditorInnerId;
				play.
			self assert: scripter expandedBehaviorAt: 1.

			scripter editor
				moveRight;
				typeText: ' ';
				// GtSourceCoderEditorInnerId;
				play.
			self assert: scripter expandedBehaviorAt: 1.

			scripter editor
				typeText: 'o';
				// GtSourceCoderEditorInnerId;
				play.
			self assert: scripter behaviorExpandersCount: 0.

			scripter editor
				typeText: '.';
				// GtSourceCoderEditorInnerId;
				play.

			self assert: scripter expandedBehaviorAt: 1 ].

	^ scripter
]

{ #category : #accessing }
GtPharoClassExpanderStylerExamples >> classExpanderAttributesIn: ropedText [
	| attributes |
	attributes := OrderedCollection new.
	1 to: ropedText size do: [ :i | 
		(ropedText attributesAt: i)
			do: [ :attr | 
				(attr isKindOf: GtPharoClassExpanderAttribute)
					ifTrue: [ attributes add: attr ] ] ].
	^ attributes
]

{ #category : #accessing }
GtPharoClassExpanderStylerExamples >> classExpanderWithMarkerHiddingAndCachingElementAttributesIn: ropedText [
	| attributes |
	attributes := OrderedCollection new.
	1 to: ropedText size do: [ :i | 
		(ropedText attributesAt: i)
			do: [ :attr | 
				(attr isKindOf: GtPharoClassExpanderWithMarkerHidingAndCachingElementAttribute)
					ifTrue: [ attributes add: attr ] ] ].
	^ attributes
]

{ #category : #accessing }
GtPharoClassExpanderStylerExamples >> classExpanderWithMarkerHiddingElementAttributesIn: ropedText [
	| attributes |
	attributes := OrderedCollection new.
	1 to: ropedText size do: [ :i | 
		(ropedText attributesAt: i)
			do: [ :attr | 
				(attr isKindOf: GtPharoClassExpanderWithMarkerHidingElementAttribute)
					ifTrue: [ attributes add: attr ] ] ].
	^ attributes
]

{ #category : #development }
GtPharoClassExpanderStylerExamples >> click: aStep behaviorExpanderAt: anInteger [
	aStep click
		label: ('Click behavior expander at {1}' format: {anInteger});
		// (GtPharoBehaviorExpanderId indexed: anInteger);
		play
]

{ #category : #accessing }
GtPharoClassExpanderStylerExamples >> existingClass [

	<gtExample>
	| coder text |
	coder := GtPharoMethodCoder
		         forClass: Object
		         source: 'foo |oc| oc := OrderedCollection new'.
	text := coder currentSourceText copy.

	GtPharoClassExpanderStyler new
		coderViewModel: coder asCoderViewModel;
		style: text ast: coder astSync.

	self assert:
		((self classExpanderAttributesIn: text) anySatisfy: [ :each | 
			 each expandedClass = OrderedCollection ]).

	^ text
]

{ #category : #development }
GtPharoClassExpanderStylerExamples >> expanderStylerVersion: anInteger during: aBlock [
	| parserSetting versionSetting |
	parserSetting := GtTextualCoder useIncrementalParsing.
	versionSetting := GtPharoClassExpanderStyler usedVersion.

	[ GtTextualCoder useIncrementalParsing: true.
	GtPharoClassExpanderStyler usedVersion: anInteger.
	aBlock value ]
		ensure: [ 
			GtTextualCoder useIncrementalParsing: parserSetting.
			GtPharoClassExpanderStyler usedVersion: versionSetting ]
]

{ #category : #accessing }
GtPharoClassExpanderStylerExamples >> missingClass [

	<gtExample>
	| coder text |
	coder := GtPharoMethodCoder
		         forClass: Object
		         source: 'foo |oc| oc := Foobar2 new'.
	text := coder currentSourceText copy.

	GtPharoClassExpanderStyler new
		coderViewModel: coder asCoderViewModel;
		style: text ast: coder astSync.

	self assert:
		((self classExpanderAttributesIn: text) noneSatisfy: [ :each | 
			 each expandedClass = OrderedCollection ]).

	^ text
]

{ #category : #development }
GtPharoClassExpanderStylerExamples >> useIncrementalParsingDuring: aBlock [
	| parserSetting |
	parserSetting := GtTextualCoder useIncrementalParsing.
	
	[ GtTextualCoder useIncrementalParsing: true.
	aBlock value ]
		ensure: [ 
			GtTextualCoder useIncrementalParsing: parserSetting.]
]
