Class {
	#name : #GtSearchFilterAndFilterModelConversionResults,
	#superclass : #Object,
	#instVars : [
		'results'
	],
	#category : 'GToolkit-Pharo-Coder-Examples-Filters'
}

{ #category : #'gt - extensions' }
GtSearchFilterAndFilterModelConversionResults >> gtResultsFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Results';
		items: [ self results ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 40;
		column: 'Search filter class'
			text: [ :aResult | 
				| aText |
				aText := aResult searchFilterClass asRopedText.
				aResult searchFilterClass isAbstract
					ifTrue: [ aText
							foreground: BrGlamorousColors disabledButtonTextColor;
							italic ].
				aText ]
			weight: 2.5;
		column: 'Name' text: [ :aResult | aResult filterModelName ];
		column: 'Priority' text: [ :aResult | aResult filterModelOrder ] weight: 0.7;
		column: 'Evaluation'
			text: [ :aResult | 
				aResult isWithResults
					ifTrue: [ 'OK' ]
					ifFalse: [ | aText |
						aText := 'Skipped' asRopedText.
						aResult isWithDescriptorClassSideMethod
							ifTrue: [ aText foreground: BrGlamorousColors failureBackgroundColor ].
						aText ] ]
			weight: 0.7;
		column: 'Has class method'
			text: [ :aResult | 
				aResult isWithDescriptorClassSideMethod
					ifTrue: [ 'yes' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]
					ifFalse: [ 'no' ] ];
		column: 'Has instance method'
			text: [ :aResult | 
				aResult isWithDescriptorInstanceSideMethod
					ifTrue: [ 'yes' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]
					ifFalse: [ | aText |
						aText := 'no' asRopedText.
						aResult isWithDescriptorClassSideMethod
							ifTrue: [ aText foreground: BrGlamorousColors failureBackgroundColor ].
						aText ] ];
		column: 'Coder with class'
			text: [ :aResult | 
				aResult methodsCoder isForClass
					ifTrue: [ 'yes' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]
					ifFalse: [ 'no' ] ]
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResults >> results [
	^ results
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResults >> results: anObject [
	results := anObject
]
