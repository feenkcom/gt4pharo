Class {
	#name : #GtMethodAdviceExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples'
}

{ #category : #accessing }
GtMethodAdviceExamples >> globalActiveMethodAdvices [
	<gtExample>
	| all |
	all := GtMethodAdvice activeAdvices.
	self assert: (all includes: GtMethodNotUsedAdvice) not.
	self assert: (all includes: GtSendNotUsedAdvice) not.
	^ all
]
