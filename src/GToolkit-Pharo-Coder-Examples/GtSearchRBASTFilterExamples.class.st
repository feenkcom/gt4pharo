Class {
	#name : #GtSearchRBASTFilterExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Filters'
}

{ #category : #examples }
GtSearchRBASTFilterExamples >> literalReferences [
	<gtExample>
	| filter methods |
	filter := '#(999 111)' gtASTMatches.
	[ #(999 111) = self ] value.	"Here to match the filter"
	methods := self timeout: filter.
	self assert: (methods includes: thisContext method).
	^ filter
]

{ #category : #examples }
GtSearchRBASTFilterExamples >> patternBlocks [
	<gtExample>
	| filter methods minFilter |
	filter := '`@a isCollection `{:node :dict | (node isVariable or: [node isMessage])}'
			gtASTMatches.
	methods := self timeout: filter.
	minFilter := #isCollection gtReferences & #isVariable gtReferences
			& #isMessage gtReferences.	"Likely this is the only method that has all three"
	self assert: methods size > minFilter size.
	^ filter
]

{ #category : #examples }
GtSearchRBASTFilterExamples >> selfPrintString [
	<gtExample>
	| filter methods |
	filter := 'self printString' gtASTMatches.
	self printString.
	methods := self timeout: filter.
	self assert: (methods includes: thisContext method).
	^ filter
]

{ #category : #private }
GtSearchRBASTFilterExamples >> timeout: aFilter [
	| semaphore value |
	semaphore := Semaphore new.
	[ value := aFilter contents.
	semaphore signal ] forkAt: Processor activePriority - 1.
	^ semaphore
		waitTimeoutMilliseconds: 15000
		onCompletion: [ value ]
		onTimeout: [ self error: 'Filter did not return in required time' ]
]
