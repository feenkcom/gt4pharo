Class {
	#name : #GtFilteredMethodCoderElementExamples,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-Coder-Examples-Filters - UI'
}

{ #category : #'examples - support' }
GtFilteredMethodCoderElementExamples >> basicFilteredMethodsCoder [
	<gtExample>
	| aCoder |
	aCoder := GtClassMethodsCoder new.
	^ aCoder
]

{ #category : #'examples - ui' }
GtFilteredMethodCoderElementExamples >> basicFiltersElement [
	<gtExample>
	| anElement |
	anElement := GtFiltersElement new.
	self assert: anElement descriptors isEmptyOrNil.
	self assert: anElement childrenCount equals: 1.
	self assert: (anElement childAt: 1) class equals: BrButton.
	^ anElement
]

{ #category : #'examples - ui' }
GtFilteredMethodCoderElementExamples >> coderWithFiltersElement [
	<gtExample>
	| aFiltersElement aCoder aCoderElement |
	aCoder := self filteredMethodsCoder.
	aCoderElement := aCoder asElement.
	aFiltersElement := self filtersElemenFrom: aCoderElement.
	self assert: aFiltersElement descriptors isNotNil.
	self assert: aFiltersElement descriptors isNotEmpty.
	self assert: aFiltersElement childrenCount = 1.
	^ aCoder
]

{ #category : #'examples - ui' }
GtFilteredMethodCoderElementExamples >> emptyFiltersElement [
	<gtExample>
	| aFiltersElement aCoder aCoderElement |
	aCoder := self coderWithFiltersElement.
	aCoderElement := aCoder asElement.
	aFiltersElement := self filtersElemenFrom: aCoderElement.
	aFiltersElement removeFromParent.
	^ aFiltersElement
]

{ #category : #'examples - support' }
GtFilteredMethodCoderElementExamples >> filteredMethodsCoder [
	<gtExample>
	| aCoder aClass |
	aCoder := self basicFilteredMethodsCoder.
	aClass := GtFiltersDummyObjectWithAllExampleStates.
	aCoder forClass: aClass.
	self assert: aCoder classOrMetaClass equals: aClass.
	^ aCoder
]

{ #category : #'examples - ui' }
GtFilteredMethodCoderElementExamples >> filtersElemenFrom: aCoderElement [
	<gtExample>
	| aFiltersElement |
	aFiltersElement := aCoderElement childAt: 1.
	self assert: aFiltersElement class equals: GtFiltersElement.
	^ aFiltersElement
]
