Class {
	#name : #GtPharoMethodChangedSelectorIndicator,
	#superclass : #GtPharoMethodModificationIndicator,
	#instVars : [
		'originalSelector',
		'compiledMethodThatWillChange'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support - Modification Model'
}

{ #category : #private }
GtPharoMethodChangedSelectorIndicator >> compiledMethodThatWillChange [
	^ compiledMethodThatWillChange
]

{ #category : #private }
GtPharoMethodChangedSelectorIndicator >> compiledMethodThatWillChange: aCompiledMethodOrNil [
	compiledMethodThatWillChange := aCompiledMethodOrNil
]

{ #category : #'api - testing' }
GtPharoMethodChangedSelectorIndicator >> isChangeIndicationRequired [
	"Return true if a user should be informed about the change, false otherwise."

	<return: #Boolean>
	^ compiledMethodThatWillChange isNotNil
]

{ #category : #converting }
GtPharoMethodChangedSelectorIndicator >> listItemElementClass [
	^ GtPharoMethodChangedSelectorIndicatorElement
]

{ #category : #accessing }
GtPharoMethodChangedSelectorIndicator >> originalSelector [
	^ originalSelector
]

{ #category : #accessing }
GtPharoMethodChangedSelectorIndicator >> originalSelector: aSymbol [
	originalSelector := aSymbol
]

{ #category : #printing }
GtPharoMethodChangedSelectorIndicator >> printIndicatorOn: aStream [
	aStream nextPutAll: 'Selector changed from '.
	aStream print: self originalSelector.
	aStream nextPutAll: ' to '.
	aStream print: self prospectiveSelector
]
