Class {
	#name : #GtMethodCriticExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples'
}

{ #category : #accessing }
GtMethodCriticExamples >> globalActiveCritics [
	<gtExample>
	| all |
	all := GtMethodCritic activeCritics.
	self assert: (all includes: GtMethodNotUsedCritic) not.
	self assert: (all includes: GtSendNotUsedCritic) not.
	^ all
]
