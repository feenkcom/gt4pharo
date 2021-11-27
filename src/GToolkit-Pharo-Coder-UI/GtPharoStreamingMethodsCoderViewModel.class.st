Class {
	#name : #GtPharoStreamingMethodsCoderViewModel,
	#superclass : #GtStreamingCodersViewModel,
	#category : #'GToolkit-Pharo-Coder-UI-! View Models'
}

{ #category : #'api  - coders' }
GtPharoStreamingMethodsCoderViewModel >> expandAndFocusCompiledMethod: aCompiledMethod [
	self enqueueCommand: (GtPharoExpandMethodCoderViewModelCommand new
		behaviorName: aCompiledMethod methodClass name;
		selector: aCompiledMethod selector)
]

{ #category : #initialization }
GtPharoStreamingMethodsCoderViewModel >> initialize [
	super initialize.
	
	monitor := Monitor new.
	coderViewModels := Dictionary new
]

{ #category : #'instance creation' }
GtPharoStreamingMethodsCoderViewModel >> newCoderViewModelFor: aCoderModel [
	^ aCoderModel asCoderViewModel expanded: false
]

{ #category : #'api  - coders' }
GtPharoStreamingMethodsCoderViewModel >> scrollToCompiledMethod: aCompiledMethod [
	self scrollToTarget: (GtPharoMethodCoderViewModelScrollTarget new
		behaviorName: aCompiledMethod methodClass name;
		selector: aCompiledMethod selector)
]
