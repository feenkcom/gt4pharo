Class {
	#name : #GtPharoClassExpanderStylerExampleResult,
	#superclass : #Object,
	#instVars : [
		'coderViewModel',
		'text',
		'styler',
		'attributes'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : #accessing }
GtPharoClassExpanderStylerExampleResult >> attributes [
	^ attributes
]

{ #category : #accessing }
GtPharoClassExpanderStylerExampleResult >> attributes: anObject [
	attributes := anObject
]

{ #category : #accessing }
GtPharoClassExpanderStylerExampleResult >> coderViewModel [
	^ coderViewModel
]

{ #category : #accessing }
GtPharoClassExpanderStylerExampleResult >> coderViewModel: anObject [
	coderViewModel := anObject
]

{ #category : #views }
GtPharoClassExpanderStylerExampleResult >> gtCoderLiveFor: aView [
	<gtView>
	^ aView forward
		title: 'Coder';
		priority: 1.5;
		object: [ coderViewModel ];
		view: #gtLiveFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'View model'
			tooltip: 'Inspect coder view model'
			action: [ :aButton | aButton phlow spawnObject: coderViewModel ];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Styler'
			tooltip: 'Inspect coder view model behavior styler'
			action: [ :aButton | 
				aButton phlow
					spawnObject: (coderViewModel stylers
							detect: [ :each | each class = GtPharoClassExpanderStyler ]) ]
]

{ #category : #views }
GtPharoClassExpanderStylerExampleResult >> gtExpanderAttributesFor: aView [
	<gtView>
	attributes ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Expander attributes';
		priority: 3;
		items: [ attributes ];
		column: 'Value' text: [ :each | each gtDisplayString ]
]

{ #category : #views }
GtPharoClassExpanderStylerExampleResult >> gtStylerAstCacheFor: aView [
	<gtView>
	^ aView forward
		title: 'Styler AST cache';
		priority: 10;
		object: [ styler ];
		view: #gtAttributesCacheFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Styler'
			tooltip: 'Inspect styler'
			action: [ :aButton | aButton phlow spawnObject: styler ];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Cache'
			tooltip: 'Inspect styler AST cache'
			action: [ :aButton | aButton phlow spawnObject: styler privateAttributesCache ]
]

{ #category : #views }
GtPharoClassExpanderStylerExampleResult >> gtStylerBehaviorCacheFor: aView [
	<gtView>
	^ aView forward
		title: 'Styler behavior cache';
		priority: 11;
		object: [ styler ];
		view: #gtBehaviorCacheFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Styler'
			tooltip: 'Inspect styler'
			action: [ :aButton | aButton phlow spawnObject: styler ];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Cache'
			tooltip: 'Inspect styler behavior cache'
			action: [ :aButton | aButton phlow spawnObject: styler privateBehaviorCache ]
]

{ #category : #views }
GtPharoClassExpanderStylerExampleResult >> gtTextAttributesFor: aView [
	<gtView>
	^ aView forward
		title: 'Text attributes';
		priority: 2;
		object: [ text ];
		view: #gtAttributeTreeFor:
]

{ #category : #views }
GtPharoClassExpanderStylerExampleResult >> gtTextFor: aView [
	<gtView>
	^ aView forward
		priority: 1;
		title: 'Text';
		object: [ text ];
		view: #gtTextFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Text'
			tooltip: 'Inspect text'
			action: [ :aButton | aButton phlow spawnObject: text ]
]

{ #category : #accessing }
GtPharoClassExpanderStylerExampleResult >> styler [
	^ styler
]

{ #category : #accessing }
GtPharoClassExpanderStylerExampleResult >> styler: anObject [
	styler := anObject
]

{ #category : #accessing }
GtPharoClassExpanderStylerExampleResult >> text [
	^ text
]

{ #category : #accessing }
GtPharoClassExpanderStylerExampleResult >> text: anObject [
	text := anObject
]
