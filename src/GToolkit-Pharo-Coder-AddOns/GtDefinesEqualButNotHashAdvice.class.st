Class {
	#name : #GtDefinesEqualButNotHashAdvice,
	#superclass : #GtMethodAdvice,
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
GtDefinesEqualButNotHashAdvice >> description [
	^ 'Class defines #=, but not a corresponding #hash method. This may cause problems when using hashed collections.'
]

{ #category : #'as yet unclassified' }
GtDefinesEqualButNotHashAdvice >> fixItActionsForNode: aNode coderModel: coderModel [
	^ {GtDefineHashFunctionFixItAction new methodClass: coderModel behavior}
]

{ #category : #testing }
GtDefinesEqualButNotHashAdvice >> matches: aNode from: aCriticRunner [
	aNode isErrorNode ifTrue: [ ^ false ].
	aNode isMethodPattern ifFalse: [ ^ false ].
	aNode selector = #= ifFalse: [ ^ false ].
	^ (aCriticRunner behavior includesSelector: #hash) not
]

{ #category : #accessing }
GtDefinesEqualButNotHashAdvice >> name [
	^ 'Defines #= but not #hash'
]

{ #category : #accessing }
GtDefinesEqualButNotHashAdvice >> potentialFilter [
	^ #= gtImplementors asAsyncStream
]
