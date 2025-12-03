Class {
	#name : #GtFilterMethodCodersAdditionalFiltersUpdater,
	#superclass : #Object,
	#instVars : [
		'coders',
		'filtersModel'
	],
	#category : 'GToolkit-Pharo-Coder-Examples-Support'
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
GtFilterMethodCodersAdditionalFiltersUpdater >> filtersModel: aModel [
	filtersModel := aModel.

	aModel weak
		when: GtFiltersModelUpdated
		send: #onFiltersUpdated:
		to: self
]

{ #category : #'event handling' }
GtFilterMethodCodersAdditionalFiltersUpdater >> onFiltersUpdated: anAnnouncement [
	| someFilters |
	coders ifNil: [ ^ self ].
	self assert: [ anAnnouncement model == self filtersModel ].
	
	someFilters := self filtersModel items
			collect: [ :eachFilterModel | self createFilterFromModel: eachFilterModel ]
			thenReject: #isNil.

	coders additionalFilters: someFilters
]
