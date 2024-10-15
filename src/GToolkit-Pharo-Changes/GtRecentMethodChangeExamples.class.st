Class {
	#name : #GtRecentMethodChangeExamples,
	#superclass : #Object,
	#traits : 'TGtExampleAssertable',
	#classTraits : 'TGtExampleAssertable classTrait',
	#category : #'GToolkit-Pharo-Changes-Examples'
}

{ #category : #asserting }
GtRecentMethodChangeExamples >> assert: actual equals: expected [
	^ self
		assert: (expected sameContentAs: actual)
		description: [ self comparingStringBetween: actual and: expected ]
]

{ #category : #accessing }
GtRecentMethodChangeExamples >> simpleMethodChange [
	<gtExample>
	| methodChange |
	methodChange := GtRecentMethodChange
			method: GtRecentMethodChangeExamples >> #simpleMethodChange
			timestamp: DateAndTime now.
			
	self assert: methodChange displayForTree equals: #simpleMethodChange.

	^ methodChange
]
