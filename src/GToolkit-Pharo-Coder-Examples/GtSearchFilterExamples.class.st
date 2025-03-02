Class {
	#name : #GtSearchFilterExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Filters'
}

{ #category : #examples }
GtSearchFilterExamples >> searchToFilterModelAndViceVersa [
	<gtExample>
	| aMethodsCoder aCollection anExamplesSuiteModel aTestSuiteModel aGtSearchFilter2 aMethodsCoder2 allClasses aGtSearchFilter3 aMethodsCoder3 |
	aMethodsCoder := GtPharoStreamingMethodsCoder
			forBehavior: GtPharoDummyTwoObject.
	anExamplesSuiteModel := GtPharoExampleSuite
			forStream: aMethodsCoder itemsStream.
	aMethodsCoder exampleSuite: anExamplesSuiteModel.
	aTestSuiteModel := GtPharoTestSuite forStream: aMethodsCoder itemsStream.
	aMethodsCoder testSuite: aTestSuiteModel.

	aGtSearchFilter2 := GtSearchDeprecatedMethodsFilter new.
	aMethodsCoder2 := GtPharoStreamingMethodsCoder forFilter: aGtSearchFilter2.
	
	aGtSearchFilter3 := GtSearchDeprecatedMethodsFilter new
		requesterContext: (GtSearchMethodCoderFilterContext new
			behavior: BlElement).
	aMethodsCoder3 := GtPharoStreamingMethodsCoder forFilter: aGtSearchFilter3.

	self assert: aMethodsCoder isForClass.
	self assert: aMethodsCoder2 isForClass not.

	allClasses := GtSearchMethodsFilter allSubclasses.
	allClasses sort: [ :a :b | a name < b name ].

	aCollection := Array
			streamContents: [ :aStream | 
				allClasses
					do: [ :eachSearchClass | 
						self
							searchToFilterModelAndViceVersaFor: eachSearchClass
							methodsCoders: {aMethodsCoder. aMethodsCoder2. aMethodsCoder3}
							into: aStream ] ].


	^ GtSearchFilterAndFilterModelConversionResults new results: aCollection
]

{ #category : #examples }
GtSearchFilterExamples >> searchToFilterModelAndViceVersaFor: aSearchClass methodsCoders: someMethodsCoders into: aStream [
	<gtExample>
	| aResult |
	aSearchClass isAbstract ifTrue: [ ^ nil ].

	aResult := GtSearchFilterAndFilterModelConversionResult new.
	aResult searchFilterClass: aSearchClass.
	aStream nextPut: aResult.

	someMethodsCoders
		do: [ :eachMethodsCoder | 
			aResult methodsCoder: eachMethodsCoder.
			self searchToFilterModelAndViceVersaIntoResult: aResult.
			aResult isWithResults ifTrue: [ ^ aResult ] ].

	^ aResult
]

{ #category : #examples }
GtSearchFilterExamples >> searchToFilterModelAndViceVersaIntoResult: aResult [
	<gtExample>
	| aSearchClass aMethodsCoder aFilterModelOne aFilterModelTwo isFilterModelTwoChanged aSearchFilterOne aSearchFilterTwo aSearchFilterThree aFilterModelThree aFilterModelFour aFilterModelFive |
	aSearchClass := aResult searchFilterClass.
	aMethodsCoder := aResult methodsCoder.

	"Two filter model instances of the same search class are equal."
	aFilterModelOne := aSearchClass filterDescriptor2For: aMethodsCoder.
	aFilterModelOne ifNil: [ ^ aResult ].
	aFilterModelTwo := aSearchClass filterDescriptor2For: aMethodsCoder.
	self assert: aFilterModelOne equals: aFilterModelTwo.
	self assert: (aFilterModelOne equals: aFilterModelTwo).

	"Two search filter instances of equal filter model instances are equal."
	aSearchFilterOne := aFilterModelOne asSearchFilter.
	aSearchFilterTwo := aFilterModelTwo asSearchFilter.
	self assert: aSearchFilterOne isNotNil.
	self assert: aSearchFilterOne equals: aSearchFilterTwo.
	self assert: aSearchFilterOne filterType equals: aSearchFilterTwo filterType.
	
	"Two filter model instances of equal search filter instances are equal."
	aFilterModelThree := aSearchFilterOne filterDescriptor2For: aMethodsCoder.
	aFilterModelFour := aSearchFilterTwo filterDescriptor2For: aMethodsCoder.
	self
		assert: aFilterModelThree isNotNil
		description: [ '`aSearchFilterOne filterDescriptor2For: aMethodsCoder` must return a search filter but returns nil' ].
	self
		assert: aFilterModelThree
		equals: aFilterModelFour.

	"Change selected items"
	isFilterModelTwoChanged := false.
	(aFilterModelTwo isKindOf: GtFilterTextModel)
		ifTrue: [ isFilterModelTwoChanged := true.
			aFilterModelTwo text: aFilterModelTwo text asString , ' different value' ].
	((aFilterModelTwo isKindOf: GtFilterShortListModel)
		or: [ aFilterModelTwo isKindOf: GtFilterToggleModel ])
		ifTrue: [ isFilterModelTwoChanged := true.
			aFilterModelTwo
				selectedItem: ((aFilterModelTwo itemsFuture wait reject: [ :each | each = aFilterModelTwo selectedItem ])
						ifNotEmpty: #anyOne
						ifEmpty: [ 'random value' ]) ].
	(aFilterModelTwo isKindOf: GtFilterBooleanModel)
		ifTrue: [ isFilterModelTwoChanged := true.
			aFilterModelTwo switchedOn: aFilterModelTwo switchedOn not ].
	
	"Compare two model/search filters with different and same selected values"
	isFilterModelTwoChanged
		ifTrue: [ 
			self
				assert: aFilterModelOne selectedValue ~= aFilterModelTwo selectedValue
				description: [ 'The two model filters must have different selected values: {1} selectedValue ~= {2} selectedValue'
						format: {aFilterModelOne.
								aFilterModelTwo} ].
			self
				assert: aFilterModelOne = aFilterModelTwo
				description: [ 'The two model filters with different selected items must be equal using `#=`: {1} = {2}'
						format: {aFilterModelOne.
								aFilterModelTwo} ].
			self
				assert: (aFilterModelOne equals: aFilterModelTwo) not
				description: [ 'The two model filters must not be equal using `#equals:`: {1} ~= {2}'
						format: {aFilterModelOne.
								aFilterModelTwo} ].
								
			"Compare search filters with different selected values"
			aSearchFilterThree := aFilterModelTwo asSearchFilter.
			self assert: aSearchFilterThree isNotNil.
			self
				assert: aSearchFilterOne ~= aSearchFilterThree
				description: [ 'The two search filters must not be equal: {1} ~= {2}'
						format: {aSearchFilterOne.
								aSearchFilterThree} ].
			self
				assert: aSearchFilterTwo ~= aSearchFilterThree
				description: [ 'The two search filters must not be equal: {1} ~= {2}'
						format: {aSearchFilterTwo.
								aSearchFilterThree} ].
			self
				assert: aSearchFilterTwo filterType = aSearchFilterThree filterType
				description: [ 'The two search filters must be of the same type: {1} filterType = {2} filterType'
						format: {aSearchFilterTwo.
								aSearchFilterThree} ].
								
			"Compare filter models"
			aFilterModelFive := aSearchFilterThree filterDescriptor2For: aMethodsCoder.
			self assert: aFilterModelFive isNotNil.
			self
				assert: aFilterModelTwo = aFilterModelFive
				description: [ 'The two model filters with same selected items must be equal using `#=`: {1} = {2}'
						format: {aFilterModelTwo.
								aFilterModelFive} ].
			self
				assert: (aFilterModelTwo equals: aFilterModelFive)
				description: [ 'The two model filters with same selected items must be equal using `#equals:`: {1} = {2}'
						format: {aFilterModelTwo.
								aFilterModelFive} ]. ].

	aResult filterModelOne: aFilterModelOne.
	aResult filterModelTwo: aFilterModelTwo.
	aResult filterModelThree: aFilterModelThree.
	aResult filterModelFour: aFilterModelFour.
	aResult filterModelFive: aFilterModelFive.
	aResult isFilterModelTwoChanged: isFilterModelTwoChanged.
	aResult searchFilterOne: aSearchFilterOne.
	aResult searchFilterTwo: aSearchFilterTwo.
	aResult searchFilterThree: aSearchFilterThree.
	
	^ aResult
]
