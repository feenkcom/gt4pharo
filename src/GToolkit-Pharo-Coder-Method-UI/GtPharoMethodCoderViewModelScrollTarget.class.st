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

{ #category : #accessing }
GtPharoMethodCoderViewModelScrollTarget >> selector [

	^ selector
]

{ #category : #accessing }
GtPharoMethodCoderViewModelScrollTarget >> selector: anObject [

	selector := anObject
]
