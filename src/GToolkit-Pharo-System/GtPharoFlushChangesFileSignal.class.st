Class {
	#name : #GtPharoFlushChangesFileSignal,
	#superclass : #GtExamplesReportSignal,
	#instVars : [
		'stack'
	],
	#category : #'GToolkit-Pharo-System'
}

{ #category : #'instance creation' }
GtPharoFlushChangesFileSignal class >> emit [
	^ self new emit
]

{ #category : #'instance creation' }
GtPharoFlushChangesFileSignal class >> emitIfOutsideModifier [
	thisContext stack
		detect: [ :each | each method methodClass = GtPharoCodeModifier ]
		ifNone: [ self emit ]
]

{ #category : #'instance creation' }
GtPharoFlushChangesFileSignal class >> signalIfOutsideModifier: anObject [
	thisContext stack
		detect: [ :each | each method methodClass = GtPharoCodeModifier ]
		ifNone: [
			((anObject isKindOf: BinaryFileStream)
				and: [ (anObject name endsWith: '.changes') not ])
					ifTrue: [ ^ self ].
			
			NonInteractiveTranscript stdout
				nextPutAll: 'Tried to modify pharo code outside of the ', GtPharoCodeModifier name, ' critical: block';
				cr.
			
			thisContext stack do: [ :each |
				NonInteractiveTranscript stdout
					print: each;
					cr. ].
			
			Error signal: 'Tried to modify pharo code outside of the ', GtPharoCodeModifier name, ' critical: block' ]
]

{ #category : #inspecting }
GtPharoFlushChangesFileSignal >> gtInspectorStackIn: composite [
	<gtInspectorPresentationOrder: 0>
	composite list 
		title: 'Stack';
		display: [ self stack ]
]

{ #category : #accessing }
GtPharoFlushChangesFileSignal >> prepareForDelivery [
	"I only store the stack when a concrete logger is interested in me"
	self stack
]

{ #category : #accessing }
GtPharoFlushChangesFileSignal >> printOn: stream [
	super printOn: stream.
	self stack do: [ :each |
		stream 
			cr;
			tab; 
			nextPutAll: (
				each asString 
					copyReplaceAll: String cr 
					with: String cr, 
							String tab, 
							String tab) ]
]

{ #category : #accessing }
GtPharoFlushChangesFileSignal >> relevantStackWithoutSelf [
	| s |
	s := thisContext stack collect: #copy.
	^ s allButFirst: (s findLast: [ :each | each receiver = self class ])
]

{ #category : #accessing }
GtPharoFlushChangesFileSignal >> stack [
	^ stack ifNil: [ stack := self relevantStackWithoutSelf ]
]
