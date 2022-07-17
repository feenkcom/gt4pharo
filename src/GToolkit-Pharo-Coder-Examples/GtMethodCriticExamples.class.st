Class {
	#name : #GtMethodCriticExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples'
}

{ #category : #accessing }
GtMethodCriticExamples >> globalActiveMethodAdvices [
	<gtExample>
	| all |
	all := GtMethodAdvice activeCritics.
	self assert: (all includes: GtMethodNotUsedAdvice) not.
	self assert: (all includes: GtSendNotUsedAdvice) not.
	^ all
]
