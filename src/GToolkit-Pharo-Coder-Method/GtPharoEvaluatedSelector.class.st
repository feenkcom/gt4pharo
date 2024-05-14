Class {
	#name : #GtPharoEvaluatedSelector,
	#superclass : #Object,
	#traits : 'TGtSourceCoderEvaluatedCode',
	#classTraits : 'TGtSourceCoderEvaluatedCode classTrait',
	#instVars : [
		'receiver',
		'methodSelector',
		'methodArguments'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Context'
}

{ #category : #accessing }
GtPharoEvaluatedSelector >> methodArguments [
	^ methodArguments
]

{ #category : #accessing }
GtPharoEvaluatedSelector >> methodArguments: anObject [
	methodArguments := anObject
]

{ #category : #accessing }
GtPharoEvaluatedSelector >> methodSelector [
	^ methodSelector
]

{ #category : #accessing }
GtPharoEvaluatedSelector >> methodSelector: anObject [
	methodSelector := anObject
]

{ #category : #accessing }
GtPharoEvaluatedSelector >> receiver [
	^ receiver
]

{ #category : #accessing }
GtPharoEvaluatedSelector >> receiver: anObject [
	receiver := anObject
]
