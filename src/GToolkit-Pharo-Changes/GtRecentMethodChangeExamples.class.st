Class {
	#name : #GtRecentMethodChangeExamples,
	#superclass : #Object,
	#traits : 'TGtExampleAssertable',
	#classTraits : 'TGtExampleAssertable classTrait',
	#category : #'GToolkit-Pharo-Changes-Examples'
}

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
