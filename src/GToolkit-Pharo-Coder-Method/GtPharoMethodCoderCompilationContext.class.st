Class {
	#name : #GtPharoMethodCoderCompilationContext,
	#superclass : #GtPharoSourceCoderEvaluationContext,
	#instVars : [
		'behavior'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Context'
}

{ #category : #accessing }
GtPharoMethodCoderCompilationContext >> hasTargetBehavior [
	"Return true if the target behavior is specified"
	<return: #Boolean>

	^ behavior notNil
]

{ #category : #accessing }
GtPharoMethodCoderCompilationContext >> targetBehavior [
	"Return a target behavior in which the method should be compiled. The target behavior can differ from
	the method's behavior if for example the method originates from the trait"
	<return: #Behavior>

	^ behavior
]

{ #category : #accessing }
GtPharoMethodCoderCompilationContext >> targetBehavior: aBehavior [
	"Specify a behavior in which context the source code should be compiled"

	behavior := aBehavior
]
