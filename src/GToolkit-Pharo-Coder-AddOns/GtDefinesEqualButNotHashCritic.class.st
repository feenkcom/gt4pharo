Class {
	#name : #GtDefinesEqualButNotHashCritic,
	#superclass : #GtMethodCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtDefinesEqualButNotHashCritic >> description [
	^ 'Class defines #=, but not a corresponding #hash method. This may cause problems when using hashed collections.'
]

{ #category : #testing }
GtDefinesEqualButNotHashCritic >> matches: aNode from: aCriticRunner [
	aNode isMethodPattern ifFalse: [ ^ false ].
	aNode selector = #= ifFalse: [ ^ false ].
	^ (aCriticRunner behavior includesSelector: #hash) not
]

{ #category : #accessing }
GtDefinesEqualButNotHashCritic >> name [
	^ 'Defines #= but not #hash'
]

{ #category : #accessing }
GtDefinesEqualButNotHashCritic >> potentialFilter [
	^ #= gtImplementors asAsyncStream
]
