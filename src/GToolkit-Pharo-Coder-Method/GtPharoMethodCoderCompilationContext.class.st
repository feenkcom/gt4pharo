Class {
	#name : #GtPharoMethodCoderCompilationContext,
	#superclass : #GtPharoSourceCoderEvaluationContext,
	#instVars : [
		'behavior'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Context'
}

{ #category : #accessing }
GtPharoMethodCoderCompilationContext >> behavior [
	<return: #Behavior>

	^ behavior
]

{ #category : #accessing }
GtPharoMethodCoderCompilationContext >> behavior: aBehavior [
	"Specify a behavior in which context the source code should be compiled"

	behavior := aBehavior
]
