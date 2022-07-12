Class {
	#name : #GtRBNamespaceExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-AddOns-Examples'
}

{ #category : #accessing }
GtRBNamespaceExamples >> implementersOfPrintOn [
	<gtExample>
	| environment implementers |
	environment := GtRBNamespace onEnvironment: RBBrowserEnvironment new.
	implementers := environment allImplementorsOf: #printOn:.
	self assert: implementers notEmpty.
	implementers do: [:each | self assert: (each isKindOf: RBClass)].
	^ implementers
]

{ #category : #accessing }
GtRBNamespaceExamples >> referencesToPrintOn [
	<gtExample>
	| environment references |
	environment := GtRBNamespace onEnvironment: RBBrowserEnvironment new.
	references := environment allReferencesTo: #printOn:.
	self assert: references notEmpty.
	references do: [:each | self assert: (each isKindOf: RBMethod)].
	^ references
]
