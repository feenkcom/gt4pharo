Class {
	#name : #GtPharoMethodCoderEvaluationContextExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Coder - Method'
}

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderEvaluationContextExamples >> evaluationContextForNewCoder [
	<gtExample>
	| aMethodCoder anEvaluationContext |
	
	aMethodCoder := GtPharoMethodCoder new.

	anEvaluationContext := aMethodCoder evaluationContext.
	self assert: anEvaluationContext hasTargetBehavior not.
	
	^ anEvaluationContext
]

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderEvaluationContextExamples >> evaluationContextForNewMethod [
	<gtExample>
	| aMethodCoder anEvaluationContext |
	
	aMethodCoder := GtPharoMethodCoder forNewMethod: GtPharoCoderMockedClass.

	anEvaluationContext := aMethodCoder evaluationContext.
	self assert: anEvaluationContext hasTargetBehavior.
	self assert: anEvaluationContext targetBehavior equals: GtPharoCoderMockedClass.
	
	^ anEvaluationContext
]

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderEvaluationContextExamples >> evaluationContextFromSameClass [
	<gtExample>
	| aMethodCoder anEvaluationContext |
	
	aMethodCoder := GtPharoMethodCoder forMethod: GtPharoCoderMockedClass >> #classMethodB.

	anEvaluationContext := aMethodCoder evaluationContext.
	self assert: anEvaluationContext hasTargetBehavior.
	self assert: anEvaluationContext targetBehavior equals: GtPharoCoderMockedClass.
	
	^ anEvaluationContext
]

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderEvaluationContextExamples >> evaluationContextFromSameTrait [
	<gtExample>
	| aMethodCoder anEvaluationContext |

	aMethodCoder := GtPharoMethodCoder forMethod: TGtPharoCoderMockedTrait >> #traitMethodA.

	anEvaluationContext := aMethodCoder evaluationContext.
	self assert: anEvaluationContext hasTargetBehavior.
	self assert: anEvaluationContext targetBehavior equals: TGtPharoCoderMockedTrait.
	
	^ anEvaluationContext
]

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderEvaluationContextExamples >> evaluationContextFromTrait [
	<gtExample>
	| aMethodCoder anEvaluationContext |

	aMethodCoder := GtPharoMethodCoder forMethod: GtPharoCoderMockedClass >> #traitMethodA.

	anEvaluationContext := aMethodCoder evaluationContext.
	self assert: anEvaluationContext hasTargetBehavior.
	self assert: anEvaluationContext targetBehavior equals: TGtPharoCoderMockedTrait.
	
	^ anEvaluationContext
]

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderEvaluationContextExamples >> evaluationContextFromTraitOverridden [
	<gtExample>
	| aMethodCoder anEvaluationContext |

	aMethodCoder := GtPharoMethodCoder forMethod: GtPharoCoderMockedClass >> #traitMethodB.

	anEvaluationContext := aMethodCoder evaluationContext.
	self assert: anEvaluationContext hasTargetBehavior.
	self assert: anEvaluationContext targetBehavior equals: GtPharoCoderMockedClass.
	
	^ anEvaluationContext
]
