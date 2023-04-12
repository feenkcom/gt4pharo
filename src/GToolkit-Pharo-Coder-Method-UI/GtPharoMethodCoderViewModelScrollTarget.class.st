Class {
	#name : #GtPharoMethodCoderViewModelScrollTarget,
	#superclass : #GtStreamingCodersViewModelScrollTarget,
	#instVars : [
		'behaviorName',
		'selector'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Utilities'
}

{ #category : #'api - testing' }
GtPharoMethodCoderViewModelScrollTarget >> applicableTo: aCoderViewModel [
	^ (aCoderViewModel behavior name = behaviorName
		and: [ aCoderViewModel selector = selector ])
]

{ #category : #accessing }
GtPharoMethodCoderViewModelScrollTarget >> behaviorName [

	^ behaviorName
]

{ #category : #accessing }
GtPharoMethodCoderViewModelScrollTarget >> behaviorName: anObject [

	behaviorName := anObject
]

{ #category : #printing }
GtPharoMethodCoderViewModelScrollTarget >> printOn: aStream [
	super printOn: aStream.

	self behaviorName ifNil: [ ^ self ].
	self selector ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self behaviorName asString;
		nextPutAll: '>>';
		print: self selector;
		nextPut: $)
]

{ #category : #printing }
GtPharoMethodCoderViewModelScrollTarget >> printTargetNameOn: aStream [
	aStream
		nextPutAll: self behaviorName asString;
		nextPutAll: '>>';
		print: self selector
]

{ #category : #accessing }
GtPharoMethodCoderViewModelScrollTarget >> selector [

	^ selector
]

{ #category : #accessing }
GtPharoMethodCoderViewModelScrollTarget >> selector: anObject [

	selector := anObject
]
