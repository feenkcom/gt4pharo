Class {
	#name : #GtPharoClassExpanderStylerExamples,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-Coder-Examples-Stylers'
}

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
