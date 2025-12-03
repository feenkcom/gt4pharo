Class {
	#name : #GtMethodsCoderExamples,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : #'examples - filters' }
GtMethodsCoderExamples >> doFilter [
	<gtExample>
	^ GtSearchImplementorsFilter selector: #do:
]

{ #category : #'examples - coder' }
GtMethodsCoderExamples >> doImplementorsCoder [
	<gtExample>
	^ self doFilter asCoder
]

{ #category : #'examples - filters' }
GtMethodsCoderExamples >> emptyInstanceSlotsFilter [
	"Empty variable names implies that all method matches.
	This is due to filter descriptors that can have 'All methods' selected item.
	See GtSearchInstanceSlotReferenceFilter class>>#filterDescriptor2For:"
	<gtExample>

	| aFilter |
	aFilter := GtSearchInstanceSlotReferenceFilter
			forClass: HashedCollection
			andVariable: ''.

	self assert: (aFilter matches: HashedCollection  >> #grow).
	self assert: (aFilter matches: HashedCollection  >> #union:).
	self assert: (aFilter matches: HashedCollection class >> #empty).

	^ aFilter
]

{ #category : #'examples - filters' }
GtMethodsCoderExamples >> errorFilter [
	<gtExample>
	^ GtSearchReferencesFilter literal: #error:
]

{ #category : #'examples - coder' }
GtMethodsCoderExamples >> errorReferencesCoder [
	<gtExample>

	^ self errorFilter asCoder
]

{ #category : #accessing }
GtMethodsCoderExamples >> exceptionProcessCoderExample [
	<gtExample>
	^ GtProcessCoder forProcess: self suspendedErrorProcess
]

{ #category : #'examples - coder' }
GtMethodsCoderExamples >> gtExamplesCoder [
	<gtExample>
	| methods |
	methods := self gtExamplesFilter result.
	self assert: (methods toArray wait includes: thisContext method).
	^ methods asCoder
]

{ #category : #'examples - filters' }
GtMethodsCoderExamples >> gtExamplesFilter [
	<gtExample>
	^ #gtExample gtPragmas
]

{ #category : #accessing }
GtMethodsCoderExamples >> inheritedMethods [
	<gtExample>
	| coders associationMethod compilationTargets |
	coders := GtPharoStreamingMethodsCoder
			forBehavior: GtPharoStreamingMethodsCoder.
	coders additionalFilters: OrderedCollection new.
	associationMethod := (coders codersStream
			select: [ :each | each selector = #'->' and: [ each behavior = Object ] ])
			toArray wait.
	self assert: associationMethod size equals: 1.
	compilationTargets := associationMethod first methodBehavior asyncSubclasses
			toArray wait.
	self assert: (compilationTargets includes: GtPharoStreamingMethodsCoder).
	^ coders
]

{ #category : #'examples - filters' }
GtMethodsCoderExamples >> instanceSlotsFilter [
	<gtExample>
	| aFilter |
	aFilter := GtSearchInstanceSlotReferenceFilter forClass: HashedCollection andVariable: 'array'.
	
	self assert: (aFilter matches: HashedCollection  >> #grow).
	self assert: (aFilter matches: HashedCollection  >> #union:) not.
	self assert: (aFilter matches: HashedCollection class >> #empty) not.

	^ aFilter
]

{ #category : #'examples - coder' }
GtMethodsCoderExamples >> instanceVariableReferenceCoder [
	<gtExample>
	^ self instanceSlotsFilter asCoder
]

{ #category : #'examples - coder' }
GtMethodsCoderExamples >> intersectionCoder [
	<gtExample>
	^ (self instanceSlotsFilter & self doFilter) asCoder
]

{ #category : #'examples - class coder' }
GtMethodsCoderExamples >> methodsCoderWithClass [
	<gtExample>
	| classCoder |
	classCoder :=  GtClassMethodsCoder forClass: Object.
	
	self assert: classCoder classOrMetaClass equals: Object.
	self assert: classCoder object equals: nil.
	
	^ classCoder
]

{ #category : #'examples - coder' }
GtMethodsCoderExamples >> methodsCoderWithExplicitMethods [
	<gtExample>
	^ GtPharoMethodsCoder forItems: { Object>>#printString . Object >>#printOn: }
]

{ #category : #'examples - filters' }
GtMethodsCoderExamples >> printStringFilter [
	<gtExample>
	^ GtSearchReferencesFilter literal: #printString
]

{ #category : #accessing }
GtMethodsCoderExamples >> processCoderExample [
	<gtExample>
	^ GtProcessCoder forProcess: self suspendedProcess
]

{ #category : #'examples - filters' }
GtMethodsCoderExamples >> selectFilter [
	<gtExample>
	^ self doFilter select: [ :each | (each methodClass includesBehavior: Collection) not ]
]

{ #category : #accessing }
GtMethodsCoderExamples >> suspendedErrorProcess [
	<gtExample>
	| process exception |
	process := [ [ (RBParser parseRewriteExpression: '`{:node | 42 error: 7 error: node + 1}')
		match: thisContext method ast
		inContext: Dictionary new ]
		on: Error
		do: [ :ex | 
			exception := ex.
			ex freeze.
			process suspend ] ] newProcess.
	process priority: Processor activePriority - 1.
	process resume.
	[ exception isNil ] whileTrue: [ (Delay forMilliseconds: 1) wait ].
	^ process
]

{ #category : #accessing }
GtMethodsCoderExamples >> suspendedProcess [
	<gtExample>
	| process |
	process := [ 1 second wait. 3.14 squared . 42 sqrt ] newProcess.
	process priority: Processor activePriority - 1.
	process resume.
	(Delay forMilliseconds: 2) wait.
	process suspend.
	^ process
]

{ #category : #'examples - coder' }
GtMethodsCoderExamples >> unionCoder [
	<gtExample>
	^ (self errorFilter | self printStringFilter) asCoder
]

{ #category : #accessing }
GtMethodsCoderExamples >> validateNoMemoryLeaks [
	<gtExample>
	| subscriptionCount instanceCount diffSubscriptions diffInstances |
	Smalltalk garbageCollect.
	subscriptionCount := SystemAnnouncer uniqueInstance numberOfSubscriptions.
	instanceCount := GtAsyncSearchMethodGroupStream allInstances size.
	10 timesRepeat: [ self doImplementorsCoder ].
	(Delay forMilliseconds: 100) wait.	"Need to let terminated processes finish"
	3 timesRepeat: [ Smalltalk garbageCollect ].
	diffSubscriptions := subscriptionCount - SystemAnnouncer uniqueInstance numberOfSubscriptions.
	diffInstances := instanceCount - GtAsyncSearchMethodGroupStream allInstances size.
	self assert: diffSubscriptions >= 0.
	self assert: diffInstances >= 0.
	^ {diffSubscriptions.
	diffInstances}
]
