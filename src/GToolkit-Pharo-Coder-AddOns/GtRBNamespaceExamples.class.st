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
GtRBNamespaceExamples >> implementersOfPrintOnTheSameAsDefault [
	<gtExample>
	<noTest>
	| defaultEnvironment defaultImplementers gtImplementers difference1 difference2 |
	gtImplementers := self implementersOfPrintOn.
	defaultEnvironment := RBNamespace onEnvironment: RBBrowserEnvironment new.
	defaultImplementers := defaultEnvironment allImplementorsOf: #printOn:.
	difference1 := (defaultImplementers collect: #name) \ (gtImplementers collect: #name).
	difference2 := (gtImplementers collect: #name) \ (defaultImplementers collect: #name).
	self assert: defaultImplementers size = gtImplementers size.
	self assert: difference1 isEmpty.
	self assert: difference2 isEmpty.
	^ gtImplementers
]

{ #category : #accessing }
GtRBNamespaceExamples >> rbClassesCategoriesMatchThoseInTheSystem [
	<gtExample>
	| model rb |
	model := GtRBNamespace onEnvironment: RBBrowserEnvironment new.
	Smalltalk allClassesAndTraits
		do: [ :each | 
			rb := (model createNewClassFor: each) first.
			self assert: rb category = each category ]
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
