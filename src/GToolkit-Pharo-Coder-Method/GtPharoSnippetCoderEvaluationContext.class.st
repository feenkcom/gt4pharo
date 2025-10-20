Class {
	#name : #GtPharoSnippetCoderEvaluationContext,
	#superclass : #GtPharoSourceCoderEvaluationContext,
	#category : #'GToolkit-Pharo-Coder-Method-Context'
}

{ #category : #testing }
GtPharoSnippetCoderEvaluationContext >> canAddBindingOf: aBindingName [

	"Check is a special variable named `name` can be declared but without declaring it."
	^ aBindingName first isUppercase not.
]

{ #category : #testing }
GtPharoSnippetCoderEvaluationContext >> isForScripting [
	^ true
]
