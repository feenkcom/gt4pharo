Class {
	#name : 'GtFuturePoll',
	#superclass : 'Object',
	#category : 'GToolkit-Futures-Execution'
}

{ #category : 'accessing' }
GtFuturePoll class >> pending [
	^ GtFuturePollPending uniqueInstance
]

{ #category : 'converting' }
GtFuturePoll >> asFuturePoll [
	^ self
]

{ #category : 'operators-mapping' }
GtFuturePoll >> ifReady: aReadyBlock ifPending: aPendingBlock [
	^ self isReady
		ifTrue: [ aReadyBlock cull: self ]
		ifFalse: [ aPendingBlock cull: self ]
]

{ #category : 'testing' }
GtFuturePoll >> isPending [
	^ self subclassResponsibility
]

{ #category : 'testing' }
GtFuturePoll >> isReady [
	^ self subclassResponsibility
]

{ #category : 'operators-mapping' }
GtFuturePoll >> map: aBlock [
	"Changes the ready value of this Poll with the value computed."
	<return: #GtFuturePoll>
	
	^ self subclassResponsibility
]
