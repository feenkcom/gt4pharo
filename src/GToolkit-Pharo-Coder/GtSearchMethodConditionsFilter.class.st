"
I include {{gtClass:CompiledMethod}} instances that satisfy all {{gtMethod:GtSearchMethodConditionsFilter>>#condition:|label=conditions}}. 
## Example With One Condition
{{gtExample:GtSearchMethodFilterExamples>>methodConditionsFilter_OneCondition}}
## Example With Two Conditions
{{gtExample:GtSearchMethodFilterExamples>>methodConditionsFilter_TwoConditions}}

"
Class {
	#name : 'GtSearchMethodConditionsFilter',
	#superclass : 'GtSearchMethodsFilter',
	#instVars : [
		'conditions'
	],
	#category : 'GToolkit-Pharo-Coder-Filters'
}

{ #category : 'api - instance creation' }
GtSearchMethodConditionsFilter class >> condition: aValuable [
	^ self new condition: aValuable
]

{ #category : 'api - accessing' }
GtSearchMethodConditionsFilter >> condition: aValuable [
	"Valuable is an object (block) that understands #value:.
	It must return a ${class:Boolean}$ on aValuble value: aMethod."
	self
		assert: [ aValuable isNotNil ] 
		description: [ 'Condition must be non-nil' ].
	self conditions add: aValuable
]

{ #category : 'private - accessing' }
GtSearchMethodConditionsFilter >> conditions [
	<return: #Collection of: #BlockClosure>
	^ conditions
]

{ #category : 'testing' }
GtSearchMethodConditionsFilter >> includesMethod: aMethod [
	^ self conditions allSatisfy: [ :eachValuable | 
		eachValuable value: aMethod ]
]

{ #category : 'initialization' }
GtSearchMethodConditionsFilter >> initialize [
	super initialize.
	conditions := OrderedCollection new: 1.
]

{ #category : 'api - accessing' }
GtSearchMethodConditionsFilter >> referenceClassThat: aValuable [
	"Valuable is an object (block) that understands #value:.
	It must return a ${class:Boolean}$ on aValuble value: aClass."
	self
		assert: [ aValuable isNotNil ] 
		description: [ 'Condition must be non-nil' ].
	self condition: ([ :aMethod | 
		aMethod ast allChildren 
			anySatisfy: [ :aNode | 
				aNode isVariable and: [ 
					aNode isGlobal and: [ 
						aNode binding isGlobalClassNameBinding and: [
							aValuable value: aNode binding value ] ] ] ] ])
]

{ #category : 'api - accessing' }
GtSearchMethodConditionsFilter >> referenceSubclass: aClass [
	"aClass is global class.
	It returns true if a method references aClass or its subclass."
	self
		assert: [ aClass isNotNil ] 
		description: [ 'Class must be non-nil' ].
	self referenceClassThat: [ :eachClass |
		eachClass == aClass or: [
			eachClass inheritsFrom: aClass ] ]
]
