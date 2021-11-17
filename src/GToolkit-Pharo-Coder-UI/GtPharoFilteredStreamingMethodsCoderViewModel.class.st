Class {
	#name : #GtPharoFilteredStreamingMethodsCoderViewModel,
	#superclass : #GtStreamingCodersViewModel,
	#category : #'GToolkit-Pharo-Coder-UI-! View Models'
}

{ #category : #accessing }
GtPharoFilteredStreamingMethodsCoderViewModel >> elementClass [
	^ GtPharoFilteredStreamingMethodsCoderElement
]

{ #category : #'api  - coders' }
GtPharoFilteredStreamingMethodsCoderViewModel >> expandAndFocusCompiledMethod: aCompiledMethod [
	self enqueueCommand: (GtPharoExpandMethodCoderViewModelCommand new
		behaviorName: aCompiledMethod methodClass name;
		selector: aCompiledMethod selector)
]

{ #category : #initialization }
GtPharoFilteredStreamingMethodsCoderViewModel >> initialize [
	super initialize.
	
	monitor := Monitor new.
	coderViewModels := Dictionary new
]

{ #category : #'instance creation' }
GtPharoFilteredStreamingMethodsCoderViewModel >> newCoderViewModelFor: aCoderModel [
	^ aCoderModel asCoderViewModel expanded: false
]
