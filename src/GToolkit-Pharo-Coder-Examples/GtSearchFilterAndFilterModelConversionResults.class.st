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
		column: 'Search filter class' text: #searchFilterClass
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResults >> results [
	^ results
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResults >> results: anObject [
	results := anObject
]
