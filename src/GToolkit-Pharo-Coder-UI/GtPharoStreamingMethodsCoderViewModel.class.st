Class {
	#name : #GtPharoStreamingMethodsCoderViewModel,
	#superclass : #GtFilteredCodersViewModel,
	#instVars : [
		'shouldExpandByDefault',
		'shouldHaveHeaderByDefault'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! View Models'
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
	
	shouldExpandByDefault := false.
	shouldHaveHeaderByDefault := false
]

{ #category : #'instance creation' }
GtPharoStreamingMethodsCoderViewModel >> newCoderViewModelFor: aCoderModel [
	^ aCoderModel asCoderViewModel
		expanded: shouldExpandByDefault;
		shouldHaveHeader: shouldHaveHeaderByDefault;
		highlighter: highlighter
]

{ #category : #'api - coders' }
GtPharoStreamingMethodsCoderViewModel >> scrollToCompiledMethod: aCompiledMethod [
	self scrollToTarget: (GtPharoMethodCoderViewModelScrollTarget new
		behaviorName: aCompiledMethod methodClass name;
		selector: aCompiledMethod selector)
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
