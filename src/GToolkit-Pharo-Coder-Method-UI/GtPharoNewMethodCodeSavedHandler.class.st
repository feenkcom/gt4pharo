Class {
	#name : #GtPharoNewMethodCodeSavedHandler,
	#superclass : #Object,
	#instVars : [
		'methodsCoderViewModel',
		'element',
		'methodCoderHolder'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support'
}

{ #category : #'api - announcement handling' }
GtPharoNewMethodCodeSavedHandler >> cull: aSavedEvent cull: aMethodCoderViewModel [
	self methodsCoderViewModel
		expandAndFocusCompiledMethod: aSavedEvent method;
		scrollToCompiledMethod: aSavedEvent method.
	self element fireEvent: BrDropdownHideWish new.
	self methodCoderHolder contents: nil
]

{ #category : #accessing }
GtPharoNewMethodCodeSavedHandler >> element [

	^ element
]

{ #category : #accessing }
GtPharoNewMethodCodeSavedHandler >> element: anElement [

	element := anElement.

	anElement userData at: self class put: self
]

{ #category : #accessing }
GtPharoNewMethodCodeSavedHandler >> methodCoderHolder [

	^ methodCoderHolder
]

{ #category : #accessing }
GtPharoNewMethodCodeSavedHandler >> methodCoderHolder: anObject [

	methodCoderHolder := anObject
]

{ #category : #accessing }
GtPharoNewMethodCodeSavedHandler >> methodsCoderViewModel [

	^ methodsCoderViewModel
]

{ #category : #accessing }
GtPharoNewMethodCodeSavedHandler >> methodsCoderViewModel: anObject [

	methodsCoderViewModel := anObject
]
