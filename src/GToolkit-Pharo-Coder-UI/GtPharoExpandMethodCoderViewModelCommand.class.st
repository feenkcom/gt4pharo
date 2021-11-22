Class {
	#name : #GtPharoExpandMethodCoderViewModelCommand,
	#superclass : #GtStreamingCodersViewModelCommand,
	#instVars : [
		'behaviorName',
		'selector'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! View Models'
}

{ #category : #'api - testing' }
GtPharoExpandMethodCoderViewModelCommand >> applicableTo: aCoderViewModel [
	^ (aCoderViewModel behavior name = behaviorName
		and: [ aCoderViewModel selector = selector ])
]

{ #category : #hook }
GtPharoExpandMethodCoderViewModelCommand >> applyOn: aCoderViewModel [
	aCoderViewModel
		expand;
		focused: true
]

{ #category : #accessing }
GtPharoExpandMethodCoderViewModelCommand >> behaviorName [

	^ behaviorName
]

{ #category : #accessing }
GtPharoExpandMethodCoderViewModelCommand >> behaviorName: anObject [

	behaviorName := anObject
]

{ #category : #accessing }
GtPharoExpandMethodCoderViewModelCommand >> selector [

	^ selector
]

{ #category : #accessing }
GtPharoExpandMethodCoderViewModelCommand >> selector: anObject [

	selector := anObject
]
