Class {
	#name : #GtMethodContextsCoder,
	#superclass : #GtPharoMethodsCoder,
	#instVars : [
		'debugSession'
	],
	#category : 'GToolkit-Pharo-Coder-Coders'
}

{ #category : #accessing }
GtMethodContextsCoder class >> forDebugSession: aDebugSession [

	^ self new
		  forDebugSession: aDebugSession;
		  yourself
]

{ #category : #accessing }
GtMethodContextsCoder class >> forProcess: aProcess [

	^ self forDebugSession: (DebugSession
			   named: 'Debug ' , aProcess name
			   on: aProcess
			   startedAt: aProcess suspendedContext)
]

{ #category : #accessing }
GtMethodContextsCoder >> forDebugSession: aDebugSession [

	debugSession := aDebugSession.
	self updateCoders
]

{ #category : #accessing }
GtMethodContextsCoder >> isSuspended [

	^ debugSession process notNil and: [ 
		  debugSession process isSuspended and: [ 
			  debugSession process isTerminating not and: [ 
				  debugSession process isTerminated not ] ] ]
]

{ #category : #accessing }
GtMethodContextsCoder >> newCoderFor: aContext [
	| coder |
	coder := GtPharoMethodContextCoder forContext: aContext session: debugSession.
	coder coders: self.
	^ coder
]

{ #category : #accessing }
GtMethodContextsCoder >> updateCoders [

	| context firstContext coder newCoders |
	self isSuspended
		ifTrue: [ 
			coders := coders asOrderedCollection reject: [ :each | each isDead ].
			firstContext := coders isEmpty
				                ifTrue: [ nil ]
				                ifFalse: [ coders first context ].
			context := debugSession process suspendedContext.
			newCoders := OrderedCollection new.
			[ context notNil and: [ context ~~ firstContext ] ] whileTrue: [ 
				coder := GtPharoMethodContextCoder
					         forContext: context
					         session: debugSession.
				coder announcer weak
					when: GtCoderRefreshStackAnnouncement
					send: #updateCoders
					to: self.
				newCoders add: coder.
				context := context sender ].
			coders addAllFirst: newCoders ]
		ifFalse: [ coders := OrderedCollection new ].
	self announce: (GtCodersCodersChanged new
			 coders: self;
			 yourself)
]
