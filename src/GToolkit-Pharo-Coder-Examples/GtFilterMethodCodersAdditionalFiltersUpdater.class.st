Class {
	#name : #GtFilterMethodCodersAdditionalFiltersUpdater,
	#superclass : #Object,
	#instVars : [
		'coders',
		'filtersModel'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Filters - Helpers'
}

{ #category : #accessing }
GtFilterMethodCodersAdditionalFiltersUpdater >> coders [
	^ coders
]

{ #category : #accessing }
GtFilterMethodCodersAdditionalFiltersUpdater >> coders: anObject [
	coders := anObject
]

{ #category : #private }
GtFilterMethodCodersAdditionalFiltersUpdater >> createFilterFromModel: aFilterModel [
	^ aFilterModel asSearchFilter
]

{ #category : #accessing }
GtFilterMethodCodersAdditionalFiltersUpdater >> filtersModel [
	^ filtersModel
]

{ #category : #accessing }
GtFilterMethodCodersAdditionalFiltersUpdater >> filtersModel: anObject [
	filtersModel := anObject
]

{ #category : #'event handling' }
GtFilterMethodCodersAdditionalFiltersUpdater >> onFiltersUpdated: anAnnouncement [
	| someFilters |
	someFilters := self filtersModel items
			collect: [ :eachFilterModel | self createFilterFromModel: eachFilterModel ]
			thenReject: #isNil.

	coders additionalFilters: someFilters
]
