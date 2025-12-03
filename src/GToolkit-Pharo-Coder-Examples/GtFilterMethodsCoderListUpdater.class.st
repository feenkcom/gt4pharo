Class {
	#name : #GtFilterMethodsCoderListUpdater,
	#superclass : #Object,
	#instVars : [
		'coders',
		'list'
	],
	#category : 'GToolkit-Pharo-Coder-Examples-Filters - Helpers'
}

{ #category : #accessing }
GtFilterMethodsCoderListUpdater >> coders [
	^ coders
]

{ #category : #accessing }
GtFilterMethodsCoderListUpdater >> coders: anObject [
	self assert: [ coders isNil ].
	self assert: [ anObject isNotNil ].

	coders := anObject.

	anObject
		when: GtStreamingCodersStreamChanged
		send: #onStreamChanged:
		to: self
]

{ #category : #accessing }
GtFilterMethodsCoderListUpdater >> list [
	^ list
]

{ #category : #accessing }
GtFilterMethodsCoderListUpdater >> list: anObject [
	list := anObject
]

{ #category : #'event handling' }
GtFilterMethodsCoderListUpdater >> onStreamChanged: anAnnouncement [
	self updateList
]

{ #category : #'private - updating' }
GtFilterMethodsCoderListUpdater >> updateList [
	| aStream |
	list ifNil: [ ^ self ].
	coders ifNil: [ ^ self ].

	aStream := coders asAsyncStream
			map: [ :eachCoder | eachCoder asCoderViewModel expanded: false ].

	BlTaskAction enqueueElement: list action: [ list stream: aStream ]
]
