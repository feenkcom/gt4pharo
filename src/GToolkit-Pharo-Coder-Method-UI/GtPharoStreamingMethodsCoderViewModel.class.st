Class {
	#name : #GtPharoStreamingMethodsCoderViewModel,
	#superclass : #GtFilteredCodersViewModel,
	#instVars : [
		'shouldExpandByDefault',
		'shouldHaveHeaderByDefault',
		'selfObject'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-! View Models'
}

{ #category : #'api - coders' }
GtPharoStreamingMethodsCoderViewModel >> expandAndFocusCompiledMethod: aCompiledMethod [
	self enqueueCommand: (GtPharoExpandMethodCoderViewModelCommand new
		behaviorName: aCompiledMethod methodClass name;
		selector: aCompiledMethod selector)
]

{ #category : #initialization }
GtPharoStreamingMethodsCoderViewModel >> initialize [
	super initialize.
	
	selfObject := nil.
	shouldExpandByDefault := false.
	shouldHaveHeaderByDefault := false
]

{ #category : #'instance creation' }
GtPharoStreamingMethodsCoderViewModel >> newCoderViewModelFor: aCoderModel [
	^ aCoderModel asCoderViewModel
		expanded: shouldExpandByDefault;
		shouldHaveHeader: shouldHaveHeaderByDefault;
		highlighter: highlighter;
		selfObject: selfObject
]

{ #category : #'api - coders' }
GtPharoStreamingMethodsCoderViewModel >> scrollToCompiledMethod: aCompiledMethod [
	self scrollToTarget: (GtPharoMethodCoderViewModelScrollTarget new
		behaviorName: aCompiledMethod methodClass name;
		selector: aCompiledMethod selector)
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderViewModel >> selfObject [

	^ selfObject
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderViewModel >> selfObject: anObject [
	selfObject := anObject.
	coderViewModels valuesDo: [ :eachCoderViewModel |
		eachCoderViewModel selfObject: anObject ]
]

{ #category : #'api - accessing' }
GtPharoStreamingMethodsCoderViewModel >> shouldExpandByDefault [

	^ shouldExpandByDefault
]

{ #category : #'api - accessing' }
GtPharoStreamingMethodsCoderViewModel >> shouldExpandByDefault: anObject [

	shouldExpandByDefault := anObject
]

{ #category : #'api - accessing' }
GtPharoStreamingMethodsCoderViewModel >> shouldHaveHeaderByDefault [

	^ shouldHaveHeaderByDefault
]

{ #category : #'api - accessing' }
GtPharoStreamingMethodsCoderViewModel >> shouldHaveHeaderByDefault: anObject [

	shouldHaveHeaderByDefault := anObject
]
