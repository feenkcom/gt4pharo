Class {
	#name : #GtSearchFilterAndFilterModelConversionResults,
	#superclass : #Object,
	#instVars : [
		'results'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Filters'
}

{ #category : #'gt - extensions' }
GtSearchFilterAndFilterModelConversionResults >> gtResultsFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Results';
		items: [ self results ];
		column: 'Search filter class'
			text: #searchFilterClass
			weight: 1.5;
		column: 'Evaluation status'
			text: [ :aResult | 
				aResult isWithResults
					ifTrue: [ 'OK' ]
					ifFalse: [ | aText |
						aText := 'Skipped' asRopedText.
						aResult isWithDescriptorClassSideMethod
							ifTrue: [ aText foreground: BrGlamorousColors failureBackgroundColor ].
						aText ] ];
		column: 'Has class-side definition'
			text: [ :aResult | 
				aResult isWithDescriptorClassSideMethod
					ifTrue: [ 'yes' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]
					ifFalse: [ 'no' ] ];
		column: 'Has instance-side definition'
			text: [ :aResult | 
				aResult isWithDescriptorInstanceSideMethod
					ifTrue: [ 'yes' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]
					ifFalse: [ | aText |
						aText := 'no' asRopedText.
						aResult isWithDescriptorClassSideMethod
							ifTrue: [ aText foreground: BrGlamorousColors failureBackgroundColor ].
						aText ] ]
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResults >> results [
	^ results
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResults >> results: anObject [
	results := anObject
]
