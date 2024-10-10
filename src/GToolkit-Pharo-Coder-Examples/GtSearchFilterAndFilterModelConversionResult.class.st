Class {
	#name : #GtSearchFilterAndFilterModelConversionResult,
	#superclass : #Object,
	#instVars : [
		'searchFilterClass',
		'filterModelOne',
		'filterModelTwo',
		'isFilterModelTwoChanged',
		'searchFilterOne',
		'searchFilterTwo'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Filters'
}

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> filterModelOne [
	^ filterModelOne
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> filterModelOne: anObject [
	filterModelOne := anObject
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> filterModelTwo [
	^ filterModelTwo
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> filterModelTwo: anObject [
	filterModelTwo := anObject
]

{ #category : #'gt - extensions' }
GtSearchFilterAndFilterModelConversionResult >> gtOverview [
	^ {GtPhlowOverviewItem new
			name: 'Search filter class';
			value: self searchFilterClass.
		GtPhlowOverviewItem new
			name: 'Filter model one';
			value: self filterModelOne.
		GtPhlowOverviewItem new
			name: 'Filter model two';
			value: self filterModelTwo.
		GtPhlowOverviewItem new
			name: 'Is filter model two changed';
			if: self isFilterModelTwoChanged
				description: 'Filter model two is different compared to the filter model one';
			if: self isFilterModelTwoChanged not
				description: 'Filter model two is same as the filter model one';
			value: self isFilterModelTwoChanged.
		GtPhlowOverviewItem new
			name: 'Search filter one';
			value: self searchFilterOne.
		GtPhlowOverviewItem new
			name: 'Search filter two';
			value: self searchFilterTwo}
]

{ #category : #'gt - extensions' }
GtSearchFilterAndFilterModelConversionResult >> gtOverviewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Overview';
		items: [ self gtOverview ];
		column: 'Name'
			text: #name
			weight: 0.5;
		column: 'Description' text: #description;
		send: #value
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> isFilterModelTwoChanged [
	^ isFilterModelTwoChanged
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> isFilterModelTwoChanged: anObject [
	isFilterModelTwoChanged := anObject
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> searchFilterClass [
	^ searchFilterClass
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> searchFilterClass: anObject [
	searchFilterClass := anObject
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> searchFilterOne [
	^ searchFilterOne
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> searchFilterOne: anObject [
	searchFilterOne := anObject
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> searchFilterTwo [
	^ searchFilterTwo
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> searchFilterTwo: anObject [
	searchFilterTwo := anObject
]
