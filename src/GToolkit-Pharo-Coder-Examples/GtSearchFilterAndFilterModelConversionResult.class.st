Class {
	#name : #GtSearchFilterAndFilterModelConversionResult,
	#superclass : #Object,
	#instVars : [
		'searchFilterClass',
		'filterModelOne',
		'filterModelTwo',
		'isFilterModelTwoChanged',
		'searchFilterOne',
		'searchFilterTwo',
		'methodsCoder',
		'filterModelThree',
		'filterModelFour',
		'filterModelFive',
		'searchFilterThree'
	],
	#category : 'GToolkit-Pharo-Coder-Examples-Filters'
}

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> filterModelFive [
	^ filterModelFive
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> filterModelFive: anObject [
	filterModelFive := anObject
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> filterModelFour [
	^ filterModelFour
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> filterModelFour: anObject [
	filterModelFour := anObject
]

{ #category : #'as yet unclassified' }
GtSearchFilterAndFilterModelConversionResult >> filterModelName [
	^ self filterModelOne ifNotNil: #name ifNil: [ '' ]
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> filterModelOne [
	^ filterModelOne
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> filterModelOne: anObject [
	filterModelOne := anObject
]

{ #category : #'as yet unclassified' }
GtSearchFilterAndFilterModelConversionResult >> filterModelOrder [
	^ self filterModelOne ifNotNil: #order ifNil: [ '' ]
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> filterModelThree [
	^ filterModelThree
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> filterModelThree: anObject [
	filterModelThree := anObject
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
			name: 'Methods coder';
			value: self methodsCoder.
		GtPhlowOverviewItem new
			name: 'Methods coder behavior';
			value: (self methodsCoder ifNotNil: #behavior).
		GtPhlowOverviewItem new
			name: 'Is for class';
			boolean: (self methodsCoder ifNotNil: #isForClass).
		GtPhlowOverviewItem new
			name: 'Search filter class SF';
			value: self searchFilterClass.
		GtPhlowOverviewItem new
			name: 'Filter model FM1 (from SF)';
			value: self filterModelOne.
		GtPhlowOverviewItem new
			name: 'Filter model FM2 (from SF, FM1 = unchanged FM2)';
			value: self filterModelTwo.
		GtPhlowOverviewItem new
			name: 'Is filter model FM2 changed';
			boolean: self isFilterModelTwoChanged;
			if: self isFilterModelTwoChanged
				description: 'Filter model FM2 is different compared to the filter model FM1';
			ifNot: self isFilterModelTwoChanged
				description: 'Filter model FM2 is same as the filter model FM1'.
		GtPhlowOverviewItem new
			name: 'Search filter SF1 (from FM1)';
			value: self searchFilterOne.
		GtPhlowOverviewItem new
			name: 'Search filter SF2 (from unchanged FM2, SF1 = SF2)';
			value: self searchFilterTwo.
		GtPhlowOverviewItem new
			name: 'Search filter SF3 (from changed FM2, SF2 ~= SF3)';
			value: self searchFilterThree.
		GtPhlowOverviewItem new
			name: 'Filter model FM3 (from SF1, FM1 = unchanged FM2 = FM3)';
			value: self filterModelThree.
		GtPhlowOverviewItem new
			name: 'Filter model FM4 (from SF2, FM1 = unchanged FM2 = FM3 = FM4)';
			value: self filterModelFour.
		GtPhlowOverviewItem new
			name: 'Filter model FM5 (from SF3, changed FM2 = FM5)';
			value: self filterModelFive}
]

{ #category : #'gt - extensions' }
GtSearchFilterAndFilterModelConversionResult >> gtOverviewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Overview';
		priority: 1;
		items: [ self gtOverview ];
		column: 'Name'
			text: #name
			weight: 1;
		column: 'Description' text: #description;
		send: #value
]

{ #category : #'gt - extensions' }
GtSearchFilterAndFilterModelConversionResult >> gtSearchFilterFor: aView [
	<gtView>
	^ aView explicit
		title: 'Search filters';
		priority: 10;
		stencil: [ self isWithResults
				ifTrue: [ GtCoder forObject: self searchFilterOne ]
				ifFalse: [ GtCoder forClass: self searchFilterClass ] ]
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> isFilterModelTwoChanged [
	^ isFilterModelTwoChanged
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> isFilterModelTwoChanged: anObject [
	isFilterModelTwoChanged := anObject
]

{ #category : #testing }
GtSearchFilterAndFilterModelConversionResult >> isWithDescriptorClassSideMethod [
	^ (self searchFilterClass class includesSelector: #filterDescriptor2For:)
		or: [ self searchFilterClass class includesSelector: #globalFilterDescriptor2 ]
]

{ #category : #testing }
GtSearchFilterAndFilterModelConversionResult >> isWithDescriptorInstanceSideMethod [
	^ self searchFilterClass includesSelector: #filterDescriptor2For:
]

{ #category : #testing }
GtSearchFilterAndFilterModelConversionResult >> isWithResults [
	^ self filterModelOne isNotNil
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> methodsCoder [
	^ methodsCoder
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> methodsCoder: anObject [
	methodsCoder := anObject
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
GtSearchFilterAndFilterModelConversionResult >> searchFilterThree [
	^ searchFilterThree
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> searchFilterThree: anObject [
	searchFilterThree := anObject
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> searchFilterTwo [
	^ searchFilterTwo
]

{ #category : #accessing }
GtSearchFilterAndFilterModelConversionResult >> searchFilterTwo: anObject [
	searchFilterTwo := anObject
]
