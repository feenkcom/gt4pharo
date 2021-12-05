Class {
	#name : #GtPharoMethodCoderOriginExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Coder - Method'
}

{ #category : #'examples - origin' }
GtPharoMethodCoderOriginExamples >> methodOriginForNewCoder [
	<gtExample>
	| aMethodCoder aMethodOrigin |
	
	aMethodCoder := GtPharoMethodCoder new.
	aMethodOrigin := aMethodCoder methodOrigin wait.
	
	self assert: aMethodOrigin isUnknownOrigin.
	
	^ aMethodOrigin
]

{ #category : #'examples - origin' }
GtPharoMethodCoderOriginExamples >> methodOriginForNewMethod [
	<gtExample>
	| aMethodCoder aMethodOrigin |
	
	aMethodCoder := GtPharoMethodCoder forNewMethod: GtPharoCoderMockedClass.
	aMethodOrigin := aMethodCoder methodOrigin wait.
	
	self assert: aMethodOrigin isUnknownOrigin.
	
	^ aMethodOrigin
]

{ #category : #'examples - origin' }
GtPharoMethodCoderOriginExamples >> methodOriginFromSameClass [
	<gtExample>
	| aMethodCoder aMethodOrigin |
	
	aMethodCoder := GtPharoMethodCoder forMethod: GtPharoCoderMockedClass >> #classMethodB.
	aMethodOrigin := aMethodCoder methodOrigin wait.
	
	self assert: aMethodOrigin isSameOrigin.
	self assert: aMethodOrigin behavior equals: GtPharoCoderMockedClass.
	self assert: aMethodOrigin method equals: GtPharoCoderMockedClass >> #classMethodB.
	
	^ aMethodOrigin
]

{ #category : #'examples - origin' }
GtPharoMethodCoderOriginExamples >> methodOriginFromSameTrait [
	<gtExample>
	| aMethodCoder aMethodOrigin |
	
	aMethodCoder := GtPharoMethodCoder forMethod: TGtPharoCoderMockedTrait >> #traitMethodA.
	aMethodOrigin := aMethodCoder methodOrigin wait.
	
	self assert: aMethodOrigin isSameOrigin.
	self assert: aMethodOrigin behavior equals: TGtPharoCoderMockedTrait.
	self assert: aMethodOrigin method equals: TGtPharoCoderMockedTrait >> #traitMethodA.
	
	^ aMethodOrigin
]

{ #category : #'examples - origin' }
GtPharoMethodCoderOriginExamples >> methodOriginFromTrait [
	<gtExample>
	| aMethodCoder aMethodOrigin |
	
	aMethodCoder := GtPharoMethodCoder forMethod: GtPharoCoderMockedClass >> #traitMethodA.
	aMethodOrigin := aMethodCoder methodOrigin wait.
	
	self assert: aMethodOrigin isTraitOrigin.
	self assert: aMethodOrigin trait equals: TGtPharoCoderMockedTrait.
	self assert: aMethodOrigin method equals: GtPharoCoderMockedClass >> #traitMethodA.
	
	^ aMethodOrigin
]

{ #category : #'examples - origin' }
GtPharoMethodCoderOriginExamples >> methodOriginFromTraitOverridden [
	<gtExample>
	| aMethodCoder aMethodOrigin |
	
	aMethodCoder := GtPharoMethodCoder forMethod: GtPharoCoderMockedClass >> #traitMethodB.
	aMethodOrigin := aMethodCoder methodOrigin wait.
	
	self assert: aMethodOrigin isSameOrigin.
	self assert: aMethodOrigin behavior equals: GtPharoCoderMockedClass.
	self assert: aMethodOrigin method equals: GtPharoCoderMockedClass >> #traitMethodB.
	
	^ aMethodOrigin
]
