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

{ #category : #convenience }
GtPharoMethodArgumentsCollector >> targetBehavior: aBehavior receiver: aReceiver selector: aSymbol [
	"It is recommended to use this method, since {{gtMethod: GtPharoMethodExpanderStyler >> #visitMessage:}} searches for a method class using the same logic."

	aReceiver
		ifNil: [ self targetBehavior: aBehavior selector: aSymbol ]
		ifNotNil: [ self receiver: aReceiver selector: aSymbol ]
]

{ #category : #convenience }
GtPharoMethodArgumentsCollector >> targetBehavior: aBehavior selector: aSymbol [
	self compiledMethod: (aBehavior lookupSelector: aSymbol)
]
