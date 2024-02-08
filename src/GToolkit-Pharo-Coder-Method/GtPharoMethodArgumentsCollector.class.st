Class {
	#name : #GtPharoMethodArgumentsCollector,
	#superclass : #Object,
	#instVars : [
		'evaluationContext',
		'compiledMethod'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Utilities'
}

{ #category : #building }
GtPharoMethodArgumentsCollector >> collect [
	"Currently, it returns an empty collection if there is any issue.
	It could be improved by signaling dedicated errors."

	compiledMethod ifNil: [ ^ #() ].

	^ compiledMethod argumentNames
		collect: [ :aName | 
			evaluationContext bindingStrategy
				bindingValueOf: aName
				ifPresent: [ :aValue | aValue ]
				ifAbsent: [ ^ #() ] ]
]

{ #category : #accessing }
GtPharoMethodArgumentsCollector >> compiledMethod [
	^ compiledMethod
]

{ #category : #accessing }
GtPharoMethodArgumentsCollector >> compiledMethod: anObject [
	compiledMethod := anObject
]

{ #category : #accessing }
GtPharoMethodArgumentsCollector >> evaluationContext [
	^ evaluationContext
]

{ #category : #accessing }
GtPharoMethodArgumentsCollector >> evaluationContext: anObject [
	evaluationContext := anObject
]

{ #category : #convenience }
GtPharoMethodArgumentsCollector >> receiver: aReceiver selector: aSymbol [
	self compiledMethod: (aReceiver class lookupSelector: aSymbol)
]
