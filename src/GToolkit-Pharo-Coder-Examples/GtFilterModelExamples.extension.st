Extension { #name : #GtFilterModelExamples }

{ #category : #'*GToolkit-Pharo-Coder-Examples' }
GtFilterModelExamples >> itemsModelWithMethodsCoder [
	<gtExample>
	| aModel aMethodsCoder aFilter |
	aModel := GtFilterItemsModel new.
	aMethodsCoder := GtPharoStreamingMethodsCoder forBehavior: GtPharoDummyTwoObject.
	aFilter := GtSearchInheritedMethodsFilter filterDescriptor2For: aMethodsCoder.
	aModel items: { aFilter }.
	aModel availableFiltersBuilder: (GtFilterMethodsCoderAvailableFiltersBuilder new 
		coders: aMethodsCoder).
	self assert: aModel items size equals: 1.
	self assert: aModel availableFilters size > 0.

	^ aModel
]
